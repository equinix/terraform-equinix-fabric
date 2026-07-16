package uat

import (
	"testing"
)

func TestPort2AlibabaCreateConnection_PNFV(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../examples/port-2-alibaba-connection", "TEST_DATA_UAT_PORT_2_ALIBABA_CONNECTION", "alibaba_connection_id")
}
func TestVirtualDevice2AzureCreateConnection_PNFV(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../tests/examples-without-external-providers/virtual-device-2-azure-connection", "TEST_DATA_UAT_VIRTUAL_DEVICE_2_AZURE_CONNECTION", "azure_connection_id")
}

func TestVirtualDevice2PortCreateConnection_PNFV(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../tests/examples-without-external-providers/virtual-device-2-port-connection", "TEST_DATA_UAT_VIRTUAL_DEVICE_2_PORT_CONNECTION", "port_connection_id")
}

func TestVirtualDevice2AWSCreateConnection_PNFV(t *testing.T) {
	t.Parallel()
	retryableTest(t, "../../tests/examples-without-external-providers/virtual-device-2-aws-connection", "TEST_DATA_UAT_VIRTUAL_DEVICE_2_AWS_CONNECTION", "aws_connection_id")
}
