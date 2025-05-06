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

func TestConnectionPTPCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../tests/examples-without-external-providers/port-2-precision-time-ptp",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "ptp_ept_resource_id")
	assert.NotNil(t, output)
}

func TestCloudRouterNPTCreateConnection_DIGP(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../tests/examples-without-external-providers/cloud-router-2-precision-time-npt",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "npt_ept_resource_id")
	assert.NotNil(t, output)
}
