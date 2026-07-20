package uat

import (
	"fmt"
	"os"
	"testing"
	"time"

	"github.com/equinix/terraform-equinix-fabric/tests/sweepers"
	"github.com/gruntwork-io/terratest/modules/retry"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// Default retry configuration
const (
	maxRetries   = 2                // Number of retries (total attempts = maxRetries + 1)
	sleepBetween = 30 * time.Second // Wait time between retries
)

func writeEnvToFile(envVar, filePath string) error {
	content := os.Getenv(envVar)
	if content == "" {
		return fmt.Errorf("environment variable %s is empty or not set", envVar)
	}
	return os.WriteFile(filePath, []byte(content), 0644)
}

// retryableTest wraps a terraform test with retry logic
func retryableTest(t *testing.T, terraformDir string, tfvarEnv string, outputName string) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: terraformDir,
		NoColor:      true,
	})

	if err := writeEnvToFile(tfvarEnv, terraformDir+"/terraform.tfvars.json"); err != nil {
		t.Fatalf("Unable to create tfvars file %s", err)
	}

	description := "Running terraform test with retry"
	retry.DoWithRetry(t, description, maxRetries, sleepBetween, func() (string, error) {
		// Clean up any previous state
		terraform.Init(t, terraformOptions)

		// Apply
		_, err := terraform.ApplyE(t, terraformOptions)
		if err != nil {
			// Cleanup on failure before retry
			terraform.Destroy(t, terraformOptions)
			return "", err
		}

		return "", nil
	})

	// Ensure cleanup after successful run
	defer terraform.Destroy(t, terraformOptions)

	output := terraform.Output(t, terraformOptions, outputName)
	assert.NotNil(t, output)
}

func TestMain(m *testing.M) {
	code := m.Run()
	sweepers.RunTestSweepers()
	os.Exit(code)
}
