package sweepers

import (
	"context"
	"errors"
	"fmt"
	"github.com/equinix/equinix-sdk-go/services/fabricv4"
	"log"
	"net/http"
)

func testNetworks() error {
	var errs []error
	log.Printf("[DEBUG] Sweeping Fabric Networks")
	ctx := context.Background()
	fabric, err := newFabricClient()

	name := fabricv4.NETWORKSEARCHFIELDNAME_NAME
	equalOperator := fabricv4.NETWORKFILTEROPERATOR_EQUAL
	limit := int32(100)
	offset := int32(0)

	networkSearchRequest := fabricv4.NetworkSearchRequest{
		Filter: &fabricv4.NetworkFilter{
			And:      []fabricv4.NetworkFilter{},
			Property: &name,
			Operator: &equalOperator,
			Values:   fabricTestResourceSuffixes,
		},
		Pagination: &fabricv4.PaginationRequest{
			Offset: &offset,
			Limit:  &limit,
		},
	}
	networks, _, err := fabric.NetworksApi.SearchNetworks(ctx).NetworkSearchRequest(networkSearchRequest).Execute()

	if err != nil {
		return fmt.Errorf("error getting fabric network list for sweeping fabric networks: %s", err)
	}

	for _, network := range networks.Data {
		if network.GetState() != "DELETED" && isSweepableFabricTestResource(network.GetName()) {
			log.Printf("[DEBUG] Deleting Network: %s", network.GetName())
			_, resp, err := fabric.NetworksApi.DeleteNetworkByUuid(ctx, network.GetUuid()).Execute()
			if resp.StatusCode == http.StatusForbidden || resp.StatusCode == http.StatusNotFound {
				errs = append(errs, fmt.Errorf("error deleting fabric network: %s", err))
			}
		}
	}

	return errors.Join(errs...)
}
