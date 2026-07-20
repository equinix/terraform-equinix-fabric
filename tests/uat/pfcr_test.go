package uat

import (
	"testing"
)

func TestPFCR(t *testing.T) {
	tests := []struct {
		name   string
		dir    string
		env    string
		output string
	}{
		{"Port2Aws", "../../tests/examples-without-external-providers/port-2-aws-connection", "TEST_DATA_UAT_PORT_2_AWS_CONNECTION", "aws_connection_id"},
		{"Port2Azure", "../../tests/examples-without-external-providers/port-2-azure-connection", "TEST_DATA_UAT_PORT_2_AZURE_CONNECTION", "azure_connection_id"},
		{"Port2Ibm2", "../../tests/examples-without-external-providers/port-2-ibm2-connection", "TEST_DATA_UAT_PORT_2_IBM2_CONNECTION", "ibm2_connection_id"},
		{"Port2Port", "../../examples/port-2-port-connection", "TEST_DATA_UAT_PORT_2_PORT_CONNECTION", "port_connection_id"},
		{"Port2PrivateSP", "../../examples/port-2-private-service-profile-connection", "TEST_DATA_UAT_PORT_2_PRIVATE_SERVICE_PROFILE_CONNECTION", "private_sp_connection_id"},
		{"Port2PublicSP", "../../examples/port-2-public-service-profile-connection", "TEST_DATA_UAT_PORT_2_PUBLIC_SERVICE_PROFILE_CONNECTION", "public_sp_connection_id"},
		{"FCR2Aws", "../../tests/examples-without-external-providers/cloud-router-2-aws-connection", "TEST_DATA_UAT_CLOUD_ROUTER_2_AWS_CONNECTION", "aws_connection_id"},
		{"FCR2Azure", "../../tests/examples-without-external-providers/cloud-router-2-azure-connection", "TEST_DATA_UAT_CLOUD_ROUTER_2_AZURE_CONNECTION", "azure_connection_id"},
		{"FCR2SP", "../../examples/cloud-router-2-service-profile-connection", "TEST_DATA_UAT_CLOUD_ROUTER_2_SERVICE_PROFILE_CONNECTION", "service_profile_connection_id"},
		{"FCR2VD", "../../tests/examples-without-external-providers/cloud-router-2-virtual-device-connection", "TEST_DATA_UAT_CLOUD_ROUTER_2_VIRTUAL_DEVICE_CONNECTION", "FCR_VD_Connection"},
		{"FCR2WAN", "../../examples/cloud-router-2-wan-connection", "TEST_DATA_UAT_CLOUD_ROUTER_2_WAN_CONNECTION", "wan_connection_id"},
		{"FCR2Port", "../../tests/examples-without-external-providers/cloud-router-2-port-connection-with-routing-protocols-and-route-filters", "TEST_DATA_UAT_CLOUD_ROUTER_2_PORT_ROUTING_PROTOCOL_AND_ROUTE_FILTER_CONNECTION", "port_connection_id"},
	}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			t.Parallel()
			retryableTest(t, test.dir, test.env, test.output)
		})
	}

	streamTests := []struct {
		name   string
		dir    string
		env    string
		output string
	}{
		{"StreamDatadog", "../../examples/stream-datadog-subscription", "TEST_DATA_UAT_STREAM_DATADOG_SUBSCRIPTION", "datadog_subscription"},
		{"StreamGrafana", "../../examples/stream-grafana-subscription", "TEST_DATA_UAT_STREAM_GRAFANA_SUBSCRIPTION", "grafana_subscription"},
		{"StreamMsteams", "../../examples/stream-msteams-subscription", "TEST_DATA_UAT_STREAM_MSTEAMS_SUBSCRIPTION", "msteams_subscription"},
		{"StreamMultiple", "../../examples/stream-multiple-subscriptions-with-port-connection-attachment", "TEST_DATA_UAT_STREAM_MULTIPLE_SUBSCRIPTIONS_AND_ATTACHMENT", "first_stream"},
		{"StreamPagerDuty", "../../examples/stream-pagerduty-subscription", "TEST_DATA_UAT_STREAM_PAGERDUTY_SUBSCRIPTION", "pagerduty_subscription"},
		{"StreamServiceNow", "../../examples/stream-servicenow-subscription", "TEST_DATA_UAT_STREAM_SERVICENOW_SUBSCRIPTION", "servicenow_subscription"},
		{"StreamSlack", "../../examples/stream-slack-subscription", "TEST_DATA_UAT_STREAM_SLACK_SUBSCRIPTION", "slack_subscription"},
		{"StreamSplunk", "../../examples/stream-splunk-subscription", "TEST_DATA_UAT_STREAM_SPLUNK_SUBSCRIPTION", "splunk_subscription"},
		{"StreamWebhook", "../../examples/stream-webhook-subscription", "TEST_DATA_UAT_STREAM_WEBHOOK_SUBSCRIPTION", "webhook_subscription"},
	}

	for _, test := range streamTests {
		t.Run(test.name, func(t *testing.T) {
			retryableTest(t, test.dir, test.env, test.output)
		})
	}
}

func TestSTSPFCR(t *testing.T) {
	retryableTest(t, "../../examples/port-2-port-connection-sts-token", "TEST_DATA_UAT_PORT_2_PORT_CONNECTION_STS", "port_connection_id")
}
