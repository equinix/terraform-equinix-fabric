package uat

import (
	"github.com/equinix/terraform-equinix-fabric/tests/sweepers"
	"github.com/gruntwork-io/terratest/modules/retry"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"os"
	"testing"
	"time"
)

// Default retry configuration
const (
	maxRetries   = 2                // Number of retries (total attempts = maxRetries + 1)
	sleepBetween = 30 * time.Second // Wait time between retries
)

// retryableTest wraps a terraform test with retry logic
func retryableTest(t *testing.T, terraformDir string, outputName string) {
	var terraformOptions *terraform.Options

	description := "Running terraform test with retry"
	retry.DoWithRetry(t, description, maxRetries, sleepBetween, func() (string, error) {
		terraformOptions = terraform.WithDefaultRetryableErrors(t, &terraform.Options{
			TerraformDir: terraformDir,
		})

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

func TestPort2AlibabaCreateConnection_PNFV(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../examples/port-2-alibaba-connection", "alibaba_connection_id")
}

func TestPort2AwsCreateConnection_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../tests/examples-without-external-providers/port-2-aws-connection", "aws_connection_id")
}

func TestPort2AzureCreateConnection_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../tests/examples-without-external-providers/port-2-azure-connection", "azure_connection_id")
}

func TestPort2Ibm2CreateConnection_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../tests/examples-without-external-providers/port-2-ibm2-connection", "ibm2_connection_id")
}

func TestPort2PortCreateConnection_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../examples/port-2-port-connection", "port_connection_id")
}

func TestPort2PrivateServiceProfileCreateConnection_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../examples/port-2-private-service-profile-connection", "private_sp_connection_id")
}

func TestPort2PublicServiceProfileCreateConnection_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../examples/port-2-public-service-profile-connection", "public_sp_connection_id")
}

func TestCloudRouter2AwsCreateConnection_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../tests/examples-without-external-providers/cloud-router-2-aws-connection", "aws_connection_id")
}

func TestCloudRouter2AzureCreateConnection_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../tests/examples-without-external-providers/cloud-router-2-azure-connection", "azure_connection_id")
}

func TestCloudRouter2PortRoutingProtocolAndRouteFilterCreateConnection_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../tests/examples-without-external-providers/cloud-router-2-port-connection-with-routing-protocols-and-route-filters", "port_connection_id")
}

func TestCloudRouter2ServiceProfileCreateConnection_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../examples/cloud-router-2-service-profile-connection", "service_profile_connection_id")
}

func TestCloudRouter2WanCreateConnection_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../examples/cloud-router-2-wan-connection", "wan_connection_id")
}

func TestVirtualDevice2AzureCreateConnection_PNFV(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../tests/examples-without-external-providers/virtual-device-2-azure-connection", "azure_connection_id")
}

func TestVirtualDevice2PortCreateConnection_PNFV(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../tests/examples-without-external-providers/virtual-device-2-port-connection", "port_connection_id")
}

func TestVirtualDevice2AWSCreateConnection_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../tests/examples-without-external-providers/virtual-device-2-aws-connection", "aws_connection_id")
}

func TestStreamDatadogSubscription_PFCR(t *testing.T) {
	retryableTest(t, "../../examples/stream-datadog-subscription", "datadog_subscription")
}

func TestStreamMSTeamsSubscription_PFCR(t *testing.T) {
	retryableTest(t, "../../examples/stream-msteams-subscription", "msteams_subscription")
}

func TestStreamPagerDutySubscription_PFCR(t *testing.T) {
	retryableTest(t, "../../examples/stream-pagerduty-subscription", "pagerduty_subscription")
}

func TestStreamSlackSubscription_PFCR(t *testing.T) {
	retryableTest(t, "../../examples/stream-slack-subscription", "slack_subscription")
}

func TestStreamSplunkSubscription_PFCR(t *testing.T) {
	retryableTest(t, "../../examples/stream-splunk-subscription", "splunk_subscription")
}

func TestStreamMultipleSubscriptionsAndAttachment_PFCR(t *testing.T) {
	retryableTest(t, "../../examples/stream-multiple-subscriptions-with-port-connection-attachment", "first_stream")
}

func TestCloudRouter2VirtualDeviceCreateConnection_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../tests/examples-without-external-providers/cloud-router-2-virtual-device-connection", "FCR_VD_Connection")
}

func TestPort2PortCreateConnection_STS_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../examples/port-2-port-connection-sts-token", "port_connection_id")
}

func TestStreamServicenowSubscription_PFCR(t *testing.T) {
	retryableTest(t, "../../examples/stream-servicenow-subscription", "servicenow_subscription")
}

func TestStreamWebhookSubscription_PFCR(t *testing.T) {
	retryableTest(t, "../../examples/stream-webhook-subscription", "webhook_subscription")
}

func TestStreamGrafanaSubscription_PFCR(t *testing.T) {
	retryableTest(t, "../../examples/stream-grafana-subscription", "grafana_subscription")
}
