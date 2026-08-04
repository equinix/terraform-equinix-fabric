package prod

import (
	"testing"

	"github.com/equinix/terraform-equinix-fabric/tests/prod"
)

func TestVirtualDeviceDIGP(t *testing.T) {
	tests := []struct {
		name       string
		dir        string
		env        string
		output     string
		updateVars map[string]any
	}{
		{"VD2Aws", "../../../tests/examples-without-external-providers/virtual-device-2-aws-connection", "TEST_DATA_PROD_VIRTUAL_DEVICE_2_AWS_CONNECTION", "aws_connection_id", nil},
		{"VD2AzureWithoutVDCreation", "../../../examples/virtual-device-2-azure-connection-without-vd-creation", "TEST_DATA_PROD_VIRTUAL_DEVICE_2_AZURE_CONNECTION", "azure_connection_id", nil},
		{"VD2Port", "../../../tests/examples-without-external-providers/virtual-device-2-port-connection", "TEST_DATA_PROD_VIRTUAL_DEVICE_2_PORT_CONNECTION", "port_connection_id",
			map[string]any{
				"connection_name": "VD2Port_Name_Update",
				"bandwidth":       10,
			}},
		{"VD2Wan", "../../../tests/examples-without-external-providers/virtual-device-2-wan-connection", "TEST_DATA_PROD_VIRTUAL_DEVICE_2_WAN_CONNECTION", "wan_connection_id", nil},
	}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			t.Parallel()
			prod.RunTest(t, test.dir, test.env, test.output, test.updateVars)
		})
	}
}
