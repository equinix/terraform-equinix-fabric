## Equinix Fabric Developer Documentation

To see the documentation for the APIs that the Fabric Terraform Provider is built on
and to learn how to procure your own Client_Id and Client_Secret follow the link below:
[Equinix Fabric Developer Portal](https://developer.equinix.com/docs?page=/dev-docs/fabric/overview)

## Usage of Example as Terraform Module

To provision this example directly as a usable module please use the *Provision Instructions* provided by Hashicorp
in the upper right of this page and be sure to include at a minimum the required variables.

## Usage of Example Locally or in Your Own Configuration

*Note:* This example creates resources which cost money. Run 'terraform destroy' when you don't need these resources.

To provision this example directly, 
you should clone the github repository for this module and run terraform within this directory:

```bash
git clone https://github.com/equinix/terraform-equinix-fabric.git
cd terraform-equinix-fabric/examples/cloud-router-2-port-connection
terraform init
terraform apply
```

To use this example of the module in your own terraform configuration include the following
(You must also have variables/values defined and have the contents of versions.tf somewhere in your config):

```hcl

provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "cloud_router_port_connection" {
  source = "equinix/fabric/equinix//modules/cloud-router-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  #Aside
  aside_ap_type  = var.aside_ap_type
  aside_fcr_uuid = var.aside_fcr_uuid

  #Zside
  zside_ap_type   = var.zside_ap_type
  zside_location  = var.zside_location
  zside_port_name = var.zside_port_name
  zside_vlan_tag  = var.zside_vlan_outer_tag
}
```
