package prod

import (
	"fmt"
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func writeEnvToFile(envVar, filePath string) error {
	content := os.Getenv(envVar)
	if content == "" {
		return fmt.Errorf("environment variable %s is empty or not set", envVar)
	}
	return os.WriteFile(filePath, []byte(content), 0644)
}

func RunTest(t *testing.T, terraformDir string, tfvarEnv string, outputName string, updateVars map[string]any) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: terraformDir,
		NoColor:      true,
	})

	if err := writeEnvToFile(tfvarEnv, terraformDir+"/terraform.tfvars.json"); err != nil {
		t.Fatalf("Unable to create tfvars file %s", err)
	}
	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, outputName)
	assert.NotNil(t, output)

	if updateVars == nil {
		return
	}

	terraformOptions = terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		Vars:         updateVars,
		TerraformDir: terraformDir,
	})
	terraform.Apply(t, terraformOptions)
}
