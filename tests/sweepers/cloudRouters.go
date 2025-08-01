package sweepers

import (
	"context"
	"errors"
	"fmt"
	"github.com/equinix/equinix-sdk-go/services/fabricv4"
	"log"
	"net/http"
)

func testSweepCloudRouters() error {
	var errs []error
	log.Printf("[DEBUG] Sweeping Fabric Cloud Routers")
	ctx := context.Background()
	fabric, err := newFabricClient()

	equinixStatus := "/state"
	equalOperator := string(fabricv4.EXPRESSIONOPERATOR_EQUAL)
	limit := int32(100)
	cloudRouterSearchRequest := fabricv4.CloudRouterSearchRequest{
		Filter: &fabricv4.CloudRouterFilters{
			And: []fabricv4.CloudRouterFilter{
				{
					CloudRouterSimpleExpression: &fabricv4.CloudRouterSimpleExpression{
						Property: &equinixStatus,
						Operator: &equalOperator,
						Values:   []string{string(fabricv4.EQUINIXSTATUS_PROVISIONED)},
					},
				},
			},
		},
		Pagination: &fabricv4.PaginationRequest{
			Limit: &limit,
		},
	}

	fabricCloudRouters, _, err := fabric.CloudRoutersApi.SearchCloudRouters(ctx).CloudRouterSearchRequest(cloudRouterSearchRequest).Execute()

	if err != nil {
		return fmt.Errorf("error getting fabric cloud router list for sweeping fabric cloud routers: %s", err)
	}

	for _, cloudRouter := range fabricCloudRouters.Data {
		if isSweepableFabricTestResource(cloudRouter.GetName()) {
			log.Printf("[DEBUG] Deleting Cloud Router: %s", cloudRouter.GetName())
			resp, err := fabric.CloudRoutersApi.DeleteCloudRouterByUuid(ctx, cloudRouter.GetUuid()).Execute()
			if resp.StatusCode == http.StatusForbidden || resp.StatusCode == http.StatusNotFound {
				errs = append(errs, fmt.Errorf("error deleting fabric cloud routter: %s", err))
			}
		}
	}

	return errors.Join(errs...)
}
