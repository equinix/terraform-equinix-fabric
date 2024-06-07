package prod

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestPort2AlibabaCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../examples/port-2-alibaba-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "alibaba_connection_id")
	assert.NotNil(t, output)
}

func TestPort2AwsCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../tests/examples-without-external-providers/port-2-aws-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "aws_connection_id")
	assert.NotNil(t, output)
}

func TestPort2AzureCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../tests/examples-without-external-providers/port-2-azure-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "azure_connection_id")
	assert.NotNil(t, output)
	terraform.Apply(t, terraformOptions)

	terraformOptions = terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		Vars: map[string]interface{}{
			"connection_name": "P2Azure_Name_Update",
		},
		TerraformDir: "../../tests/examples-without-external-providers/port-2-azure-connection",
	})
	terraform.Apply(t, terraformOptions)
}

func TestPort2GoogleCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../examples/port-2-google-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "google_connection_id")
	assert.NotNil(t, output)

	terraform.Apply(t, terraformOptions)

	terraformOptions = terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		Vars: map[string]interface{}{
			"bandwidth": 100,
		},
		TerraformDir: "../../examples/port-2-google-connection",
	})
	terraform.Apply(t, terraformOptions)
}

func TestPort2Ibm2CreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../examples/port-2-ibm2-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "ibm2_connection_id")
	assert.NotNil(t, output)
}

func TestPort2PortCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../examples/port-2-port-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "port_connection_id")
	assert.NotNil(t, output)

	terraform.Apply(t, terraformOptions)

	terraformOptions = terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		Vars: map[string]interface{}{
			"connection_name": "P2Port_Name_Update",
			"bandwidth":       100,
		},
		TerraformDir: "../../examples/port-2-port-connection",
	})
	terraform.Apply(t, terraformOptions)
}

func TestPort2PrivateServiceProfileCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../examples/port-2-private-service-profile-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "private_sp_connection_id")
	assert.NotNil(t, output)
}

func TestCloudRouterCreate_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../tests/examples-without-external-providers/cloud-router",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "cloud_router_id")
	assert.NotNil(t, output)

	terraform.Apply(t, terraformOptions)

	terraformOptions = terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		Vars: map[string]interface{}{
			"fcr_name": "FCR_Name_Update",
		},
		TerraformDir: "../../tests/examples-without-external-providers/cloud-router",
	})
	terraform.Apply(t, terraformOptions)
}

func TestCloudRouter2AwsCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../tests/examples-without-external-providers/cloud-router-2-aws-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "aws_connection_id")
	assert.NotNil(t, output)
}

func TestCloudRouter2AzureCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../tests/examples-without-external-providers/cloud-router-2-azure-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "azure_connection_id")
	assert.NotNil(t, output)
}

func TestCloudRouter2PortRoutingProtocolCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../tests/examples-without-external-providers/cloud-router-2-port-routing-protocol-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "port_connection_id")
	assert.NotNil(t, output)
}

func TestCloudRouter2ServiceProfileCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../examples/cloud-router-2-service-profile-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "service_profile_connection_id")
	assert.NotNil(t, output)
}

func TestCloudRouter2WanCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../examples/cloud-router-2-wan-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "wan_connection_id")
	assert.NotNil(t, output)
	terraform.Apply(t, terraformOptions)

	terraformOptions = terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		Vars: map[string]interface{}{
			"connection_name": "FCR2WAN_Name_Update",
			"bandwidth":       50,
		},
		TerraformDir: "../../examples/cloud-router-2-wan-connection",
	})
	terraform.Apply(t, terraformOptions)
}

func TestPort2WanCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../tests/examples-without-external-providers/port-2-wan-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "wan_connection_id")
	assert.NotNil(t, output)

	terraform.Apply(t, terraformOptions)

	terraformOptions = terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		Vars: map[string]interface{}{
			"connection_name": "P2WAN_Name_Update",
			"bandwidth":       50,
		},
		TerraformDir: "../../tests/examples-without-external-providers/port-2-wan-connection",
	})
	terraform.Apply(t, terraformOptions)
}

func TestVirtualDevice2WanCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../tests/examples-without-external-providers/virtual-device-2-wan-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "wan_connection_id")
	assert.NotNil(t, output)
}

func TestVirtualDevice2AzureCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../tests/examples-without-external-providers/virtual-device-2-azure-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "azure_connection_id")
	assert.NotNil(t, output)
}

func TestVirtualDevice2PortCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../tests/examples-without-external-providers/virtual-device-2-port-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "port_connection_id")
	assert.NotNil(t, output)

	terraform.Apply(t, terraformOptions)

	terraformOptions = terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		Vars: map[string]interface{}{
			"connection_name": "VD2Port_Name_Update",
			"bandwidth":       10,
		},
		TerraformDir: "../../tests/examples-without-external-providers/virtual-device-2-port-connection",
	})
	terraform.Apply(t, terraformOptions)
}
