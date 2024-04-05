package prod

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestMetalNIMF2AWSCreateConnection(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../examples/metal-nimf-2-aws-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "metal_aws_connection_id")
	assert.NotNil(t, output)
}

func TestMetalNIMF2AzureCreateConnection(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../examples/metal-nimf-2-azure-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "metal_azure_connection_id")
	assert.NotNil(t, output)
}

func TestMetalNIMF2OracleCreateConnection(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../examples/metal-nimf-2-oracle-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "metal_oracle_connection_id")
	assert.NotNil(t, output)
}
