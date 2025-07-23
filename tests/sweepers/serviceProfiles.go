package sweepers

import (
	"context"
	"errors"
	"fmt"
	"github.com/equinix/equinix-sdk-go/services/fabricv4"
	"log"
	"net/http"
)

func testSweepServiceProfiles() error {
	var errs []error
	log.Printf("[DEBUG] Sweeping Fabric Service Profiles")
	ctx := context.Background()
	fabric, err := newFabricClient()

	limit := int32(100)
	offset := int32(0)
	equalOperator := string(fabricv4.EXPRESSIONOPERATOR_EQUAL)
	state := string(fabricv4.SERVICEPROFILESORTBY_STATE)

	serviceProfileSearchRequest := fabricv4.ServiceProfileSearchRequest{
		Filter: &fabricv4.ServiceProfileFilter{
			ServiceProfileAndFilter: &fabricv4.ServiceProfileAndFilter{
				And: []fabricv4.ServiceProfileSimpleExpression{
					{
						Property: &state,
						Operator: &equalOperator,
						Values:   []string{string(fabricv4.SERVICEPROFILESTATEENUM_ACTIVE), string(fabricv4.SERVICEPROFILESTATEENUM_PENDING_APPROVAL)},
					},
				},
			},
		},
		Pagination: &fabricv4.PaginationRequest{
			Limit:  &limit,
			Offset: &offset,
		},
	}

	fabricServiceProfiles, _, err := fabric.ServiceProfilesApi.SearchServiceProfiles(ctx).ServiceProfileSearchRequest(serviceProfileSearchRequest).Execute()

	if err != nil {
		return fmt.Errorf("error getting fabric service profiles list for sweeping fabric service profiles: %s", err)
	}

	for _, serviceProfile := range fabricServiceProfiles.Data {
		if isSweepableFabricTestResource(serviceProfile.GetName()) {
			log.Printf("[DEBUG] Deleting Service Profile: %s", serviceProfile.GetName())
			_, resp, err := fabric.ServiceProfilesApi.DeleteServiceProfileByUuid(ctx, serviceProfile.GetUuid()).Execute()
			if resp.StatusCode == http.StatusForbidden || resp.StatusCode == http.StatusNotFound {
				errs = append(errs, fmt.Errorf("error deleting fabric service profile: %s", err))
			}
		}
	}

	return errors.Join(errs...)
}
