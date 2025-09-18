locals {
  # Pre calculation to determine if port uuid is passed or name. If both throw an error saying that only one can be used,
  # and to use uuid if leveraging the port order resource before using the port connection module.
  # Name can only be used for previously created port outside of terraform.
  # Find out which is passed when they aren't both given. Use the correct data source based on that.

  # Validation - count how many inputs are provided
  port_input_count = length([
    for input in [var.aside_port_name, var.aside_port_uuid] : input if input != null && input != ""
  ])

  # Determine which method to use
  use_port_name = var.aside_port_name != null && var.aside_port_name != "" && (var.aside_port_uuid == null || var.aside_port_uuid == "")
  use_port_uuid = var.aside_port_uuid != null && var.aside_port_uuid != "" && (var.aside_port_name == null || var.aside_port_name == "")
}

# Validation check
resource "null_resource" "aside_port_validation" {
  count = local.port_input_count != 1 ? 1 : 0

  lifecycle {
    precondition {
      condition     = local.port_input_count == 1
      error_message = "Error: You must provide exactly one of 'aside_port_name' or 'aside_port_uuid', not both or neither.\n\nGuidelines:\n- Use 'aside_port_uuid' when leveraging the port order resource using the port connection module\n- Use 'aside_port_name' only for previously created ports\n\nProvided: aside_port_name='${var.aside_port_name}', aside_port_uuid='${var.aside_port_uuid}'"
    }
  }
}

# Data source for port by name
data "equinix_fabric_ports" "aside_port_by_name" {
  count = local.use_port_name ? 1 : 0
  filters {
    name = var.aside_port_name
  }
}

# Data source for port by UUID
data "equinix_fabric_port" "aside_port_by_uuid" {
  count = local.use_port_uuid ? 1 : 0
  uuid  = var.aside_port_uuid
}

data "equinix_fabric_ports" "aside_secondary_port" {
  count = var.aside_secondary_port_name != "" ? 1 : 0
  filters {
    name = var.aside_secondary_port_name
  }
}

data "equinix_fabric_service_profiles" "zside_sp" {
  count = var.zside_ap_type == "SP" ? 1 : 0
  filter {
    property = "/name"
    operator = "="
    values   = [var.zside_sp_name]
  }
}

data "equinix_fabric_ports" "zside_port" {
  count = var.zside_ap_type == "COLO" ? 1 : 0
  filters {
    name = var.zside_port_name
  }
}

resource "equinix_fabric_connection" "primary_port_connection" {
  lifecycle {
    precondition {
      condition     = local.port_input_count == 1
      error_message = "Error: You must provide exactly one of 'aside_port_name' or 'aside_port_uuid', not both or neither.\n\nGuidelines:\n- Use 'aside_port_uuid' when leveraging the port order resource using the port connection module\n- Use 'aside_port_name' only for previously created ports\n\nProvided: aside_port_name='${var.aside_port_name}', aside_port_uuid='${var.aside_port_uuid}'"
    }
  }

  name = var.connection_name
  type = var.connection_type
  notifications {
    type   = var.notifications_type
    emails = var.notifications_emails
  }
  dynamic "project" {
    for_each = var.project_id != "" ? [1] : []
    content {
      project_id = var.project_id
    }
  }
  bandwidth = var.bandwidth
  redundancy { priority = "PRIMARY" }
  order {
    purchase_order_number = var.purchase_order_number != "" ? var.purchase_order_number : null
    term_length = var.term_length >= 1 ? var.term_length: null
  }

  additional_info = var.additional_info != [] ? var.additional_info : null

  a_side {
    access_point {
      type = "COLO"
      port {
        uuid = local.use_port_uuid ? data.equinix_fabric_port.aside_port_by_uuid[0].uuid : data.equinix_fabric_ports.aside_port_by_name[0].data.0.uuid
      }
      location {
        metro_code = var.aside_location != "" ? var.aside_location : null
      }
      link_protocol {
        type       = local.use_port_uuid ? one(data.equinix_fabric_port.aside_port_by_uuid[0].encapsulation).type : one(data.equinix_fabric_ports.aside_port_by_name[0].data.0.encapsulation).type
        vlan_tag   = (local.use_port_uuid ? one(data.equinix_fabric_port.aside_port_by_uuid[0].encapsulation).type : one(data.equinix_fabric_ports.aside_port_by_name[0].data.0.encapsulation).type) == "DOT1Q" ? var.aside_vlan_tag : null
        vlan_s_tag = (local.use_port_uuid ? one(data.equinix_fabric_port.aside_port_by_uuid[0].encapsulation).type : one(data.equinix_fabric_ports.aside_port_by_name[0].data.0.encapsulation).type) == "QINQ" ? var.aside_vlan_tag : null
        vlan_c_tag = (local.use_port_uuid ? one(data.equinix_fabric_port.aside_port_by_uuid[0].encapsulation).type : one(data.equinix_fabric_ports.aside_port_by_name[0].data.0.encapsulation).type) == "QINQ" && (var.zside_ap_type != "COLO" || (var.zside_ap_type == "COLO" ? one(data.equinix_fabric_ports.zside_port[0].data.0.encapsulation).type != "QINQ" : false)) ? var.aside_vlan_inner_tag : null
      }
    }
  }

  dynamic "z_side" {
    # Service Profile Z_Side Type
    for_each = var.zside_ap_type == "SP" ? [1] : []
    content {
      access_point {
        type               = var.zside_ap_type
        authentication_key = var.zside_ap_authentication_key
        seller_region      = var.zside_seller_region != "" ? var.zside_seller_region : null
        profile {
          type = var.zside_ap_profile_type
          uuid = data.equinix_fabric_service_profiles.zside_sp[0].data.0.uuid
        }
        location {
          metro_code = var.zside_location
        }
        peering_type = var.zside_peering_type != "" ? var.zside_peering_type : null
      }
    }
  }

  dynamic "z_side" {
    # Port Z_Side Type
    for_each = var.zside_ap_type == "COLO" ? [1] : []
    content {
      access_point {
        type = var.zside_ap_type
        port {
          uuid = data.equinix_fabric_ports.zside_port[0].data.0.uuid
        }
        link_protocol {
          type       = one(data.equinix_fabric_ports.zside_port[0].data.0.encapsulation).type
          vlan_tag   = one(data.equinix_fabric_ports.zside_port[0].data.0.encapsulation).type == "DOT1Q" ? var.zside_vlan_tag : null
          vlan_s_tag = one(data.equinix_fabric_ports.zside_port[0].data.0.encapsulation).type == "QINQ" ? var.zside_vlan_tag : null
          vlan_c_tag = one(data.equinix_fabric_ports.zside_port[0].data.0.encapsulation).type == "QINQ" && (local.use_port_uuid ? one(data.equinix_fabric_port.aside_port_by_uuid[0].encapsulation).type : one(data.equinix_fabric_ports.aside_port_by_name[0].data.0.encapsulation).type) != "QINQ" ? var.zside_vlan_inner_tag : null
        }
        location {
          metro_code = var.zside_location
        }
      }
    }
  }

  dynamic "z_side" {
    #Network Z_Side Type
    for_each = var.zside_ap_type == "NETWORK" ? [1] : []
    content {
      access_point {
        type = var.zside_ap_type
        network {
          uuid = var.zside_network_uuid
        }
      }
    }
  }

  dynamic "z_side" {
    for_each = var.zside_service_token_uuid != "" ? [1] : []
    content {
      service_token {
        uuid = var.zside_service_token_uuid
      }
    }
  }
}

resource "equinix_fabric_connection" "secondary_port_connection" {
  count = var.aside_secondary_port_name != "" ? 1 : 0
  name  = var.secondary_connection_name
  type  = var.connection_type
  notifications {
    type   = var.notifications_type
    emails = var.notifications_emails
  }
  dynamic "project" {
    for_each = var.project_id != "" ? [1] : []
    content {
      project_id = var.project_id
    }
  }
  bandwidth = var.secondary_bandwidth
  redundancy {
    priority = "SECONDARY"
    group    = one(equinix_fabric_connection.primary_port_connection.redundancy).group
  }
  order {
    purchase_order_number = var.purchase_order_number != "" ? var.purchase_order_number : null
    term_length = var.term_length >= 1 ? var.term_length: null
  }

  additional_info = var.additional_info != [] ? var.additional_info : null

  a_side {
    access_point {
      type = "COLO"
      port {
        uuid = data.equinix_fabric_ports.aside_secondary_port[0].data.0.uuid
      }
      location {
        metro_code = var.aside_location != "" ? var.aside_location : null
      }
      link_protocol {
        type       = one(data.equinix_fabric_ports.aside_secondary_port[0].data.0.encapsulation).type
        vlan_tag   = one(data.equinix_fabric_ports.aside_secondary_port[0].data.0.encapsulation).type == "DOT1Q" ? var.aside_secondary_vlan_tag : null
        vlan_s_tag = one(data.equinix_fabric_ports.aside_secondary_port[0].data.0.encapsulation).type == "QINQ" ? var.aside_secondary_vlan_tag : null

        # This is adding ctag for any connection that is QINQ Aside AND not COLO on Zside OR when COLO on Zside is not QINQ Encapsulation Type
        vlan_c_tag = one(data.equinix_fabric_ports.aside_secondary_port[0].data.0.encapsulation).type == "QINQ" && (var.zside_ap_type != "COLO" || (var.zside_ap_type == "COLO" ? one(data.equinix_fabric_ports.zside_port[0].data.0.encapsulation).type != "QINQ" : false)) ? var.aside_secondary_vlan_inner_tag : null
      }
    }
  }

  dynamic "z_side" {
    # Service Profile Z_Side Type
    for_each = var.zside_ap_type == "SP" ? [1] : []
    content {
      access_point {
        type               = var.zside_ap_type
        authentication_key = var.zside_ap_authentication_key
        seller_region      = var.zside_seller_region
        profile {
          type = var.zside_ap_profile_type
          uuid = data.equinix_fabric_service_profiles.zside_sp[0].data.0.uuid
        }
        location {
          metro_code = var.zside_location
        }
        peering_type = var.zside_peering_type != "" ? var.zside_peering_type : null
      }
    }
  }

  dynamic "z_side" {
    # Port Z_Side Type
    for_each = var.zside_ap_type == "COLO" ? [1] : []
    content {
      access_point {
        type = var.zside_ap_type
        port {
          uuid = data.equinix_fabric_ports.zside_port[0].data.0.uuid
        }
        link_protocol {
          type       = one(data.equinix_fabric_ports.zside_port[0].data.0.encapsulation).type
          vlan_tag   = one(data.equinix_fabric_ports.zside_port[0].data.0.encapsulation).type == "DOT1Q" ? var.zside_secondary_vlan_tag : null
          vlan_s_tag = one(data.equinix_fabric_ports.zside_port[0].data.0.encapsulation).type == "QINQ" ? var.zside_secondary_vlan_inner_tag : null
          vlan_c_tag = one(data.equinix_fabric_ports.zside_port[0].data.0.encapsulation).type == "QINQ" && (local.use_port_uuid ? one(data.equinix_fabric_port.aside_port_by_uuid[0].encapsulation).type : one(data.equinix_fabric_ports.aside_port_by_name[0].data.0.encapsulation).type) != "QINQ" ? var.zside_secondary_vlan_inner_tag : null
        }
        location {
          metro_code = var.zside_location
        }
      }
    }
  }

  dynamic "z_side" {
    #Network Z_Side Type
    for_each = var.zside_ap_type == "NETWORK" ? [1] : []
    content {
      access_point {
        type = var.zside_ap_type
        network {
          uuid = var.zside_network_uuid
        }
      }
    }
  }

  dynamic "z_side" {
    for_each = var.zside_service_token_uuid != "" ? [1] : []
    content {
      service_token {
        uuid = var.zside_service_token_uuid
      }
    }
  }
}