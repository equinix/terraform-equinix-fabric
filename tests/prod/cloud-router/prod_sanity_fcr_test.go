package prod

import (
	"github.com/equinix/terraform-equinix-fabric/tests/sweepers"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"os"
	"testing"
)

func TestMain(m *testing.M) {
	code := m.Run()
	sweepers.RunTestSweepers()
	os.Exit(code)
}

func TestCloudRouterCreate_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../tests/examples-without-external-providers/cloud-router",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "cloud_router_id")
	assert.NotNil(t, output)

	terraformOptions = terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		Vars: map[string]interface{}{
			"fcr_name": "FCR_Name_Update",
		},
		TerraformDir: "../../../tests/examples-without-external-providers/cloud-router",
	})
	terraform.Apply(t, terraformOptions)
}

func TestCloudRouter2AwsCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../tests/examples-without-external-providers/cloud-router-2-aws-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "aws_connection_id")
	assert.NotNil(t, output)
}

func TestCloudRouter2AzureCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../tests/examples-without-external-providers/cloud-router-2-azure-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "azure_connection_id")
	assert.NotNil(t, output)
}

func TestCloudRouter2PortRoutingProtocolCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../tests/examples-without-external-providers/cloud-router-2-port-connection-with-routing-protocols-and-route-filters",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "port_connection_id")
	assert.NotNil(t, output)

	terraformOptions = terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		Vars: map[string]interface{}{
			"connection_name": "FCR2Port_Name_Update",
			"bandwidth":       100,
		},
		TerraformDir: "../../../tests/examples-without-external-providers/cloud-router-2-port-connection-with-routing-protocols-and-route-filters",
	})
	terraform.Apply(t, terraformOptions)
}

func TestCloudRouter2ServiceProfileCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../examples/cloud-router-2-service-profile-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "service_profile_connection_id")
	assert.NotNil(t, output)
}

func TestCloudRouter2WanCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../examples/cloud-router-2-wan-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "wan_connection_id")
	assert.NotNil(t, output)

	terraformOptions = terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		Vars: map[string]interface{}{
			"connection_name": "FCR2WAN_Name_Update",
			"bandwidth":       50,
		},
		TerraformDir: "../../../examples/cloud-router-2-wan-connection",
	})
	terraform.Apply(t, terraformOptions)
}
