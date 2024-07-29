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
	outputConnectionId := terraform.Output(t, terraformOptions, "metal_aws_connection_id")
	outputStatus := terraform.Output(t, terraformOptions, "metal_connection_status")

	assert.NotNil(t, outputConnectionId)
	assert.NotNil(t, outputStatus)
	assert.Equal(t, "active", outputStatus)
}

func TestMetalNIMF2AzureCreateConnection(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../examples/metal-nimf-2-azure-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	outputConnectionId := terraform.Output(t, terraformOptions, "metal_azure_connection_id")
	outputStatus := terraform.Output(t, terraformOptions, "metal_connection_status")

	assert.NotNil(t, outputConnectionId)
	assert.NotNil(t, outputStatus)
	assert.Equal(t, "active", outputStatus)
}

func TestMetalNIMF2GoogleCreateConnection(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../examples/metal-nimf-2-google-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	outputConnectionId := terraform.Output(t, terraformOptions, "Metal_Google_Connection_Id")
	outputStatus := terraform.Output(t, terraformOptions, "metal_connection_status")

	assert.NotNil(t, outputConnectionId)
	assert.NotNil(t, outputStatus)
	assert.Equal(t, "active", outputStatus)
}

func TestMetalNIMF2Ibm2CreateConnection(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../examples/metal-nimf-2-ibm2-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	outputConnectionId := terraform.Output(t, terraformOptions, "Metal_IBM2_Connection_Id")
	outputStatus := terraform.Output(t, terraformOptions, "metal_connection_status")

	assert.NotNil(t, outputConnectionId)
	assert.NotNil(t, outputStatus)
	assert.Equal(t, "active", outputStatus)
}

func TestMetalNIMF2OracleCreateConnection(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../examples/metal-nimf-2-oracle-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	outputConnectionId := terraform.Output(t, terraformOptions, "metal_oracle_connection_id")
	outputStatus := terraform.Output(t, terraformOptions, "metal_connection_status")

	assert.NotNil(t, outputConnectionId)
	assert.NotNil(t, outputStatus)
	assert.Equal(t, "active", outputStatus)
}

func TestMetalNIMF2PortCreateConnection(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../examples/metal-nimf-2-port-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	outputConnectionId := terraform.Output(t, terraformOptions, "metal_port_connection_id")
	outputStatus := terraform.Output(t, terraformOptions, "metal_connection_status")

	assert.NotNil(t, outputConnectionId)
	assert.NotNil(t, outputStatus)
	assert.Equal(t, "active", outputStatus)
}

func TestFCR2MetalNIMFCreateConnection(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../examples/cloud-router-2-metal-nimf-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	outputConnectionId := terraform.Output(t, terraformOptions, "cloud_router_metal_connection_id")
	outputStatus := terraform.Output(t, terraformOptions, "metal_connection_status")

	assert.NotNil(t, outputConnectionId)
	assert.NotNil(t, outputStatus)
	assert.Equal(t, "active", outputStatus)
}

func TestMetal2ServiceProfileCreateConnection(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../../examples/metal-nimf-2-service-profile-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()
	terraform.InitAndApply(t, terraformOptions)
	outputConnectionId := terraform.Output(t, terraformOptions, "metal_service_profile_connection_id")
	outputStatus := terraform.Output(t, terraformOptions, "metal_connection_status")

	assert.NotNil(t, outputConnectionId)
	assert.NotNil(t, outputStatus)
	assert.Equal(t, "pending", outputStatus)
}
