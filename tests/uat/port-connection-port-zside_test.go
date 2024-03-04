package uat

import (
	"fmt"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"os"
	"testing"
)

func TestPort2PortCreateConnection(t *testing.T) {
	// retryable errors in terraform testing.

	cwd, _ := os.Getwd()
	fmt.Println("Current working directory:", cwd)

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../examples/port-2-port-connection",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "connection_result")
	assert.NotNil(t, output)
}
