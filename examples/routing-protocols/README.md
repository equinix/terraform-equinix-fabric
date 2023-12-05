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
cd terraform-equinix-fabric/examples/routing-protocols
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

module "routing_protocols" {
  source = "equinix/fabric/equinix//modules/routing-protocols"

  connection_uuid = var.connection_uuid

  # Direct RP Details
  direct_rp_name         = var.direct_rp_name
  direct_equinix_ipv4_ip = var.direct_equinix_ipv4_ip
  direct_equinix_ipv6_ip = var.direct_equinix_ipv6_ip

  # BGP RP Details
  bgp_rp_name            = var.bgp_rp_name
  bgp_customer_asn       = var.bgp_customer_asn
  bgp_customer_peer_ipv4 = var.bgp_customer_peer_ipv4
  bgp_enabled_ipv4       = var.bgp_enabled_ipv4
  bgp_customer_peer_ipv6 = var.bgp_customer_peer_ipv6
  bgp_enabled_ipv6       = var.bgp_enabled_ipv6
}
```
