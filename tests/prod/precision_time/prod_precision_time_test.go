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

func TestVirtualDevicePTPCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../tests/examples-without-external-providers/virtual-device-2-precision-time-ptp",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "virtual_device_2_ptp_connection_id")
	assert.NotNil(t, output)
}

func TestCloudRouterNPTCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../tests/examples-without-external-providers/cloud-router-2-precision-time-npt",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "port_2_npt_connection_id")
	assert.NotNil(t, output)
}
