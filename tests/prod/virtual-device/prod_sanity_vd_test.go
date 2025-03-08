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

func TestVirtualDevice2WanCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../tests/examples-without-external-providers/virtual-device-2-wan-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "wan_connection_id")
	assert.NotNil(t, output)
}

func TestVirtualDevice2AzureCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../tests/examples-without-external-providers/virtual-device-2-azure-connection-with-azure",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "azure_connection_id")
	assert.NotNil(t, output)
}

func TestVirtualDevice2PortCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../tests/examples-without-external-providers/virtual-device-2-port-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "port_connection_id")
	assert.NotNil(t, output)

	terraformOptions = terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		Vars: map[string]interface{}{
			"connection_name": "VD2Port_Name_Update",
			"bandwidth":       10,
		},
		TerraformDir: "../../../tests/examples-without-external-providers/virtual-device-2-port-connection",
	})
	terraform.Apply(t, terraformOptions)
}
