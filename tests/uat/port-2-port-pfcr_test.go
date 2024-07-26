package uat_test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestPort2PortCreateConnection_PFCR(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../examples/port-2-port-connection",
	})

	defer terraform.Destroy(t, terraformOptions)
	t.Parallel()

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "port_connection_id")
	assert.NotNil(t, output)
}
