package prod

import (
	"testing"

	"github.com/equinix/terraform-equinix-fabric/tests/prod"
)

func TestPrecisionTimeDIGP(t *testing.T) {
	tests := []struct {
		name   string
		dir    string
		env    string
		output string
	}{
		{"Port2PTP", "../../../examples/port-2-precision-time-ptp", "TEST_DATA_PROD_PORT_2_PRECISION_TIME_PTP", "ptp_ept_resource_id"},
		{"FCR2NPT", "../../../tests/examples-without-external-providers/cloud-router-2-precision-time-npt", "TEST_DATA_PROD_FCR_2_PRECISION_TIME_NPT", "npt_ept_resource_id"},

		{"VD2NPT", "../../../tests/examples-without-external-providers/virtual-device-2-precision-time-npt", "TEST_DATA_PROD_VD_2_PRECISION_TIME_NPT", "npt_ept_resource_id"},
	}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			t.Parallel()
			prod.RunTest(t, test.dir, test.env, test.output, nil)
		})
	}
}
