package port

import (
	"testing"

	"github.com/equinix/terraform-equinix-fabric/tests/prod"
)

func TestPortDIGP(t *testing.T) {
	tests := []struct {
		name       string
		dir        string
		env        string
		output     string
		updateVars map[string]any
	}{
		{"Port2Alibaba", "../../../examples/port-2-alibaba-connection", "TEST_DATA_PROD_PORT_2_ALIBABA_CONNECTION", "alibaba_connection_id", nil},
		{"Port2Aws", "../../../tests/examples-without-external-providers/port-2-aws-connection", "TEST_DATA_PROD_PORT_2_AWS_CONNECTION", "aws_connection_id", nil},
		{"Port2Azure", "../../../examples/port-2-azure-connection", "TEST_DATA_PROD_PORT_2_AZURE_CONNECTION", "azure_connection_id", nil},
		{"Port2Google", "../../../examples/port-2-google-connection", "TEST_DATA_PROD_PORT_2_GOOGLE_CONNECTION", "google_connection_id", map[string]any{"bandwidth": 100}},
		{"Port2Oracle", "../../../examples/port-2-oracle-connection", "TEST_DATA_PROD_PORT_2_ORACLE_CONNECTION", "oracle_connection_id", nil},
		{"Port2PrivateSP", "../../../examples/port-2-private-service-profile-connection", "TEST_DATA_PROD_PORT_2_PRIVATE_SERVICE_PROFILE_CONNECTION", "private_sp_connection_id", nil},
		{"Port2Port", "../../../examples/port-2-port-connection", "TEST_DATA_PROD_PORT_2_PORT_CONNECTION", "port_connection_id", map[string]any{
			"connection_name": "P2Port_Name_Update",
			"bandwidth":       100,
		}},
		{"Port2Wan", "../../../tests/examples-without-external-providers/port-2-wan-connection", "TEST_DATA_PROD_PORT_2_WAN_CONNECTION", "wan_connection_id", map[string]any{
			"connection_name": "P2WAN_Name_Update",
			"bandwidth":       50,
		}},
	}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			t.Parallel()
			prod.RunTest(t, test.dir, test.env, test.output, test.updateVars)
		})
	}
}
