package uat

import (
	"testing"
)

func TestPNFV(t *testing.T) {
	tests := []struct {
		name   string
		dir    string
		env    string
		output string
	}{
		{"Port2Alibaba", "../../examples/port-2-alibaba-connection", "TEST_DATA_UAT_PORT_2_ALIBABA_CONNECTION", "alibaba_connection_id"},
		{"VD2Azure", "../../tests/examples-without-external-providers/virtual-device-2-azure-connection", "TEST_DATA_UAT_VIRTUAL_DEVICE_2_AZURE_CONNECTION", "azure_connection_id"},
		{"VD2Port", "../../tests/examples-without-external-providers/virtual-device-2-port-connection", "TEST_DATA_UAT_VIRTUAL_DEVICE_2_PORT_CONNECTION", "port_connection_id"},
		{"VD2AWS", "../../tests/examples-without-external-providers/virtual-device-2-aws-connection", "TEST_DATA_UAT_VIRTUAL_DEVICE_2_AWS_CONNECTION", "aws_connection_id"},
	}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			t.Parallel()
			retryableTest(t, test.dir, test.env, test.output)
		})
	}
}
