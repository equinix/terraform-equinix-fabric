# Fabric Cloud Router to Virtual Device Connection

This example shows how to leverage the [Fabric Cloud Router Connection Module](../../modules/cloud-router-connection/README.md)
to create a Fabric Connection from a Fabric Cloud Router to Virtual Device.

It leverages the Equinix Terraform Provider and the Fabric Cloud Router Connection
Module to setup the connection based on the parameters you have provided to this example; or based on the pattern
you see used in this example it will allow you to create a more specific use case for your own needs.

See example usage below for details on how to use this example.

<!-- Begin Example Usage (Do not edit contents) -->
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
cd terraform-equinix-fabric/examples/cloud-router-2-virtual-device-connection
terraform init
terraform apply
```

To use this example of the module in your own terraform configuration outside of the repo include the following:

```hcl
provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}
module "cloud_router_virtual_device_connection" {
  source = "equinix/fabric/equinix//modules/cloud-router-connection"

  connection_name       = var.connection_name
  connection_type       = var.connection_type
  notifications_type    = var.notifications_type
  notifications_emails  = var.notifications_emails
  bandwidth             = var.bandwidth
  purchase_order_number = var.purchase_order_number

  #Aside
  aside_ap_type         = var.aside_ap_type
  aside_fcr_uuid        = var.aside_fcr_uuid

  #Zside
  zside_ap_type         = var.zside_ap_type
  zside_vd_type         = var.zside_vd_type
  zside_vd_uuid         = var.zside_vd_uuid
  zside_interface_type  = var.zside_interface_type
  zside_interface_id    = var.zside_interface_id
  
}
```
<!-- End Example Usage -->