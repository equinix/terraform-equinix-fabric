package eia

import (
	"testing"

	"github.com/equinix/terraform-equinix-fabric/tests/prod"
)

func TestEIAPROD(t *testing.T) {
	tests := []struct {
		name   string
		dir    string
		env    string
		output string
	}{
		{"Asn", "../../../examples/asn", "TEST_DATA_PROD_ASN", "asn_id"},
		{"IpBlock", "../../../examples/ip-block", "TEST_DATA_PROD_IP_BLOCK", "ip_block_id"},
		{"InternetAccess", "../../../examples/internet-access", "TEST_DATA_PROD_INTERNET_ACCESS", "internet_access_service_id"},
	}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			t.Parallel()
			prod.RunTest(t, test.dir, test.env, test.output, nil)
		})
	}
}
