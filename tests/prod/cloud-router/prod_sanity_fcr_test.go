package prod

import (
	"testing"

	"github.com/equinix/terraform-equinix-fabric/tests/prod"
)

func TestCloudRouterDIGP(t *testing.T) {
	tests := []struct {
		name       string
		dir        string
		env        string
		output     string
		updateVars map[string]any
	}{
		{"CreateFCR", "../../../tests/examples-without-external-providers/cloud-router", "TEST_DATA_PROD_CLOUD_ROUTER", "cloud_router_id", map[string]any{
			"fcr_name": "FCR_Name_Update",
		}},
		{"FCR2Aws", "../../../tests/examples-without-external-providers/cloud-router-2-aws-connection", "TEST_DATA_PROD_CLOUD_ROUTER_2_AWS_CONNECTION", "aws_connection_id", nil},
		{"FCR2Azure", "../../../examples/cloud-router-2-azure-connection", "TEST_DATA_PROD_CLOUD_ROUTER_2_AZURE_CONNECTION", "azure_connection_id", nil},
		{"FCR2PortWithRP+RF", "../../../tests/examples-without-external-providers/cloud-router-2-port-connection-with-routing-protocols-and-route-filters", "TEST_DATA_PROD_CLOUD_ROUTER_2_PORT_ROUTING_PROTOCOL_AND_ROUTE_FILTER_CONNECTION", "port_connection_id",
			map[string]any{
				"connection_name": "FCR2Port_Name_Update",
				"bandwidth":       100,
			}},
		{"FCR2SP", "../../../examples/cloud-router-2-service-profile-connection", "TEST_DATA_PROD_CLOUD_ROUTER_2_SERVICE_PROFILE_CONNECTION", "service_profile_connection_id", nil},
		{"FCR2VD", "../../../tests/examples-without-external-providers/cloud-router-2-virtual-device-connection", "TEST_DATA_PROD_CLOUD_ROUTER_2_VIRTUAL_DEVICE_CONNECTION", "FCR_VD_Connection", nil},
		{"FCR2Wan", "../../../examples/cloud-router-2-wan-connection", "TEST_DATA_PROD_CLOUD_ROUTER_2_WAN_CONNECTION", "wan_connection_id", map[string]any{
			"connection_name": "FCR2WAN_Name_Update",
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
