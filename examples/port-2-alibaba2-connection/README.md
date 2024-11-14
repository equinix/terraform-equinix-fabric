# Fabric Port to Fabric Alibaba Profile Connection

This example shows how to leverage the [Fabric Port Connection Module](https://registry.terraform.io/modules/equinix/fabric/equinix/latest/submodules/port-connection)
to create a Fabric Connection from a Fabric Port to Fabric Alibaba Service Profile.

It leverages the Equinix Terraform Provider, the Alibaba Terraform Provider, Fabric Port Connection
Module and various Alibaba resources to setup the connection based on the parameters you have provided to this example; or based on the pattern
you see used in this example it will allow you to create a more specific use case for your own needs.

Here is a guide with step-by-step instructions for creating a connection using the Equinix Terraform Provider and the Alibaba Terraform Provider.
By following these steps, you will be able to:

1. Setup a connection through Equinix Fabric.
2. Configure and accept the connection in the Alibaba Portal.
3. Manage resources effectively using Terraform.
4. Handle cleanup operations smoothly

### Step by Step Instructions for Fabric Port to Fabric Alibaba Profile Connection

#### 1. Create Connection from Equinix Terraform Provider

Use Fabric Port Connection Module to set up the connection based on the parameters provided.

**Note:** The `connection_name` must follow one of these patterns:
* A unique `connection_name` with at most 24 characters.
* A `connection_name` with at most 12 characters combined with a random string:  
  `connection_name = "${var.connection_name}${random_string.random.result}"`

**Result of this step:**
* A unique connection_name is generated, containing a 12-character random string appended to the given name.
* The connection is created and appears in the Connections Inventory in the Fabric Portal.
* An Express Connect Physical Connection resource is created and visible in the Alibaba Console.

#### 2. Formulate main.tf and output.tf Files
Use the following resources and data sources from the example (place them as comments initially):

`data "alicloud_express_connect_physical_connections" {}`

` resource "alicloud_express_connect_virtual_border_router" {}`

`resource "null_resource" {}`

`output alicloud_express_connect_virtual_border_router {}`

`output alicloud_express_connect_virtual_border_router_id {}`

#### 3. Accept the Connection Request
Manually accept the connection request in the Alibaba Portal for the created physical connection.

#### 4. Create the Virtual Border Router (VBR) Resource
Remove the commented code for the VBR resource and the resource for the previously created physical connection.

Result of this step:
The VBR resource is created successfully and linked to the physical connection.

#### 5. [Cleanup] Delete Resources
1. Delete the VBR using terraform
2. Terminate and delete the connection manually using the Alibaba Portal

   *Note:* If you attempt to delete the Fabric connection directly, you will encounter an error:  
   `ERR-UAA-003-00: Deletion for a provisioned connection needs to be initiated from Alibaba Portal.`


See example usage below for details on how to use this example.

<!-- BEGIN_TF_DOCS -->

<!-- END_TF_DOCS -->

