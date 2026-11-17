package uat

import (
	"encoding/json"
	"fmt"
	"math/rand"
	"os"
	"strings"
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

	vlanMin = 100
	vlanMax = 2500

	duplicateVlanErrorCode  = "EQ-3142102"
	duplicateZVlanErrorCode = "EQ-3142205"
	transientStateErrorCode = "EQ-3142510"

	destroyAttempts     = 5
	destroySleepBetween = 15 * time.Second
)

// randomizeVlans puts new random VLAN tags into the tfvars file for aside_vlan_tag and zside_vlan_tag when they are defined.
func randomizeVlans(filePath string) error {
	content, err := os.ReadFile(filePath)
	if err != nil {
		return err
	}
	vars := map[string]any{}
	if err := json.Unmarshal(content, &vars); err != nil {
		return err
	}
	for _, key := range []string{"aside_vlan_tag", "zside_vlan_tag"} {
		current, ok := vars[key]
		if !ok {
			continue
		}
		vlan := vlanMin + rand.Intn(vlanMax-vlanMin+1)
		if _, isString := current.(string); isString {
			vars[key] = fmt.Sprint(vlan)
		} else {
			vars[key] = vlan
		}
	}
	updated, err := json.MarshalIndent(vars, "", "  ")
	if err != nil {
		return err
	}
	return os.WriteFile(filePath, updated, 0644)
}

// destroyWithRetry waits for a connection that is still in a transient state and retries the destroy every 15 seconds.
func destroyWithRetry(t *testing.T, options *terraform.Options) {
	var err error
	for attempt := 1; attempt <= destroyAttempts; attempt++ {
		_, err = terraform.DestroyE(t, options)
		if err == nil || !strings.Contains(err.Error(), transientStateErrorCode) {
			break
		}
		t.Logf("destroy attempt %d/%d: connection in transient state, retrying in %s", attempt, destroyAttempts, destroySleepBetween)
		time.Sleep(destroySleepBetween)
	}
	if err != nil {
		t.Fatalf("terraform destroy failed: %s", err)
	}
}

func writeEnvToFile(envVar, filePath string) error {
	content := os.Getenv(envVar)
	if content == "" {
		if _, err := os.Stat(filePath); err == nil {
			return nil
		}
		return fmt.Errorf("environment variable %s is empty or not set and %s does not exist", envVar, filePath)
	}
	return os.WriteFile(filePath, []byte(content), 0644)
}

// retryableTest wraps a terraform test with retry logic
func retryableTest(t *testing.T, terraformDir string, tfvarEnv string, outputName string) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: terraformDir,
		NoColor:      true,
	})

	if tfvarEnv != "" {
		if err := writeEnvToFile(tfvarEnv, terraformDir+"/terraform.tfvars.json"); err != nil {
			t.Fatalf("Unable to create tfvars file %s", err)
		}
	}

	tfvarsPath := terraformDir + "/terraform.tfvars.json"
	description := "Running terraform test with retry"
	retry.DoWithRetry(t, description, maxRetries, sleepBetween, func() (string, error) {
		// Clean up any previous state
		terraform.Init(t, terraformOptions)

		if err := randomizeVlans(tfvarsPath); err != nil {
			t.Logf("VLAN not randomized: %s", err)
		}

		// Apply
		_, err := terraform.ApplyE(t, terraformOptions)
		if err != nil {
			// Cleanup on failure before retry
			destroyWithRetry(t, terraformOptions)
			if strings.Contains(err.Error(), duplicateVlanErrorCode) || strings.Contains(err.Error(), duplicateZVlanErrorCode) {
				return "", fmt.Errorf("duplicate VLAN, retrying with a new one: %s", err)
			}
			return "", err
		}

		return "", nil
	})

	// Ensure cleanup after successful run
	defer destroyWithRetry(t, terraformOptions)

	output := terraform.Output(t, terraformOptions, outputName)
	assert.NotNil(t, output)
}

func TestMain(m *testing.M) {
	code := m.Run()
	if os.Getenv("SWEEP_TARGETS") != "" {
		sweepers.RunTestSweepers()
	}
	os.Exit(code)
}
