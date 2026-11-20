data "equinix_fabric_port" "aside_port" {
  uuid = var.port_uuid
}

resource "equinix_fabric_connection" "ia_vc" {
  name      = var.connection_name
  type      = "IA_VC"
  bandwidth = var.connection_bandwidth

  notifications {
    type   = "ALL"
    emails = var.notifications_emails
  }

  project {
    project_id = var.project_id
  }

  redundancy {
    priority = "PRIMARY"
  }

  a_side {
    access_point {
      type = "COLO"
      port {
        uuid = data.equinix_fabric_port.aside_port.uuid
      }
      location {
        metro_code = var.metro_code
      }
      link_protocol {
        type       = one(data.equinix_fabric_port.aside_port.encapsulation).type
        vlan_tag   = one(data.equinix_fabric_port.aside_port.encapsulation).type == "DOT1Q" ? var.vlan_tag : null
        vlan_s_tag = one(data.equinix_fabric_port.aside_port.encapsulation).type == "QINQ" ? var.vlan_tag : null
      }
    }
  }

  z_side {
    access_point {
      type = "SP"
      profile {
        type = "IA_PROFILE"
        uuid = var.service_profile_uuid
      }
      location {
        metro_code = var.metro_code
      }
    }
  }
}

resource "equinix_fabric_ip_block" "ip_block" {
  type          = var.ip_block_type
  prefix_length = var.ip_block_prefix_length

  project = {
    project_id = var.project_id
  }

  location = {
    metro_code = var.metro_code
  }

  account = {
    account_number = var.account_number
  }
}

resource "equinix_fabric_internet_access_service" "internet_access_service" {
  name      = var.name
  type      = var.type
  bandwidth = var.bandwidth

  project = {
    project_id = var.project_id
  }

  account = {
    account_number = var.account_number
  }

  billing = {
    type = var.billing_type
  }

  order = var.purchase_order_number == null ? null : {
    purchase_order_number = var.purchase_order_number
  }

  routing_protocol = {
    type               = var.routing_protocol_type
    customer_asn       = var.customer_asn
    customer_asn_range = var.customer_asn_range
    bgp_auth_key       = var.bgp_auth_key
    export_policy      = var.export_policy

    asn = var.asn_uuid == null ? null : {
      uuid = var.asn_uuid
    }

    connections = [{
      uuid = equinix_fabric_connection.ia_vc.uuid
    }]

    customer_routes = [{
      ip_block = {
        uuid = equinix_fabric_ip_block.ip_block.uuid
      }
    }]
  }
}
