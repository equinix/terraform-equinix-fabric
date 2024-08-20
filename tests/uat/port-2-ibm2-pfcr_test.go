package uat_test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestPort2Ibm2CreateConnection_PFCR(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples-without-external-providers/port-2-ibm2-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "ibm2_connection_id")
	assert.NotNil(t, output)
}
