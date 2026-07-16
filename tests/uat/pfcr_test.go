package uat

import (
	"testing"
)

func TestPort2AwsCreateConnection_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../tests/examples-without-external-providers/port-2-aws-connection", "TEST_DATA_UAT_PORT_2_AWS_CONNECTION", "aws_connection_id")
}

func TestPort2AzureCreateConnection_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../tests/examples-without-external-providers/port-2-azure-connection", "TEST_DATA_UAT_PORT_2_AZURE_CONNECTION", "azure_connection_id")
}

func TestPort2Ibm2CreateConnection_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../tests/examples-without-external-providers/port-2-ibm2-connection", "TEST_DATA_UAT_PORT_2_IBM2_CONNECTION", "ibm2_connection_id")
}

func TestPort2PortCreateConnection_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../examples/port-2-port-connection", "TEST_DATA_UAT_PORT_2_PORT_CONNECTION", "port_connection_id")
}

func TestPort2PortCreateConnection_STS_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../examples/port-2-port-connection-sts-token", "TEST_DATA_UAT_PORT_2_PORT_CONNECTION", "port_connection_id")
}

func TestPort2PrivateServiceProfileCreateConnection_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../examples/port-2-private-service-profile-connection", "TEST_DATA_UAT_PORT_2_PRIVATE_SERVICE_PROFILE_CONNECTION", "private_sp_connection_id")
}

func TestPort2PublicServiceProfileCreateConnection_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../examples/port-2-public-service-profile-connection", "TEST_DATA_UAT_PORT_2_PUBLIC_SERVICE_PROFILE_CONNECTION", "public_sp_connection_id")
}

func TestCloudRouter2AwsCreateConnection_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../tests/examples-without-external-providers/cloud-router-2-aws-connection", "TEST_DATA_UAT_CLOUD_ROUTER_2_AWS_CONNECTION", "aws_connection_id")
}

func TestCloudRouter2AzureCreateConnection_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../tests/examples-without-external-providers/cloud-router-2-azure-connection", "TEST_DATA_UAT_CLOUD_ROUTER_2_AZURE_CONNECTION", "azure_connection_id")
}

func TestCloudRouter2PortRoutingProtocolAndRouteFilterCreateConnection_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../tests/examples-without-external-providers/cloud-router-2-port-connection-with-routing-protocols-and-route-filters", "TEST_DATA_UAT_CLOUD_ROUTER_2_PORT_ROUTING_PROTOCOL_AND_ROUTE_FILTER_CONNECTION", "port_connection_id")
}

func TestCloudRouter2ServiceProfileCreateConnection_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../examples/cloud-router-2-service-profile-connection", "TEST_DATA_UAT_CLOUD_ROUTER_2_SERVICE_PROFILE_CONNECTION", "service_profile_connection_id")
}

func TestCloudRouter2WanCreateConnection_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../examples/cloud-router-2-wan-connection", "TEST_DATA_UAT_CLOUD_ROUTER_2_WAN_CONNECTION", "wan_connection_id")
}

func TestStreamDatadogSubscription_PFCR(t *testing.T) {
	retryableTest(t, "../../examples/stream-datadog-subscription", "TEST_DATA_UAT_STREAM_DATADOG_SUBSCRIPTION", "datadog_subscription")
}

func TestStreamMSTeamsSubscription_PFCR(t *testing.T) {
	retryableTest(t, "../../examples/stream-msteams-subscription", "TEST_DATA_UAT_STREAM_MSTEAMS_SUBSCRIPTION", "msteams_subscription")
}

func TestStreamPagerDutySubscription_PFCR(t *testing.T) {
	retryableTest(t, "../../examples/stream-pagerduty-subscription", "TEST_DATA_UAT_STREAM_PAGERDUTY_SUBSCRIPTION", "pagerduty_subscription")
}

func TestStreamSlackSubscription_PFCR(t *testing.T) {
	retryableTest(t, "../../examples/stream-slack-subscription", "TEST_DATA_UAT_STREAM_SLACK_SUBSCRIPTION", "slack_subscription")
}

func TestStreamSplunkSubscription_PFCR(t *testing.T) {
	retryableTest(t, "../../examples/stream-splunk-subscription", "TEST_DATA_UAT_STREAM_SPLUNK_SUBSCRIPTION", "splunk_subscription")
}

func TestStreamServicenowSubscription_PFCR(t *testing.T) {
	retryableTest(t, "../../examples/stream-servicenow-subscription", "TEST_DATA_UAT_STREAM_SERVICENOW_SUBSCRIPTION", "servicenow_subscription")
}

func TestStreamWebhookSubscription_PFCR(t *testing.T) {
	retryableTest(t, "../../examples/stream-webhook-subscription", "TEST_DATA_UAT_STREAM_WEBHOOK_SUBSCRIPTION", "webhook_subscription")
}

func TestStreamGrafanaSubscription_PFCR(t *testing.T) {
	retryableTest(t, "../../examples/stream-grafana-subscription", "TEST_DATA_UAT_STREAM_GRAFANA_SUBSCRIPTION", "grafana_subscription")
}

func TestStreamMultipleSubscriptionsAndAttachment_PFCR(t *testing.T) {
	retryableTest(t, "../../examples/stream-multiple-subscriptions-with-port-connection-attachment", "TEST_DATA_UAT_STREAM_MULTIPLE_SUBSCRIPTIONS_AND_ATTACHMENT", "first_stream")
}

func TestCloudRouter2VirtualDeviceCreateConnection_PFCR(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../tests/examples-without-external-providers/cloud-router-2-virtual-device-connection", "TEST_DATA_UAT_CLOUD_ROUTER_2_VIRTUAL_DEVICE_CONNECTION", "FCR_VD_Connection")
}
