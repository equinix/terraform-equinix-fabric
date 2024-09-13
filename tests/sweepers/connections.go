package sweepers

import (
	"context"
	"errors"
	"fmt"
	"log"
	"net/http"

	"github.com/equinix/equinix-sdk-go/services/fabricv4"
)

func testSweepConnections() error {
	var errs []error
	log.Printf("[DEBUG] Sweeping Fabric Connections")
	ctx := context.Background()
	fabric, err := newFabricClient()

	name := fabricv4.SEARCHFIELDNAME_NAME
	equinixStatus := fabricv4.SEARCHFIELDNAME_OPERATION_EQUINIX_STATUS
	likeOperator := fabricv4.EXPRESSIONOPERATOR_LIKE
	equalOperator := fabricv4.EXPRESSIONOPERATOR_EQUAL
	limit := int32(100)
	connectionsSearchRequest := fabricv4.SearchRequest{
		Filter: &fabricv4.Expression{
			And: []fabricv4.Expression{
				{
					Property: &name,
					Operator: &likeOperator,
					Values:   fabricTestResourceSuffixes,
				},
				{
					Property: &equinixStatus,
					Operator: &equalOperator,
					Values:   []string{string(fabricv4.EQUINIXSTATUS_PROVISIONED)},
				},
			},
		},
		Pagination: &fabricv4.PaginationRequest{
			Limit: &limit,
		},
	}

	fabricConnections, _, err := fabric.ConnectionsApi.SearchConnections(ctx).SearchRequest(connectionsSearchRequest).Execute()
	if err != nil {
		log.Printf("error getting connections list for sweeping fabric connections: %s", err)
		return err
	}

	for _, connection := range fabricConnections.Data {
		if isSweepableFabricTestResource(connection.GetName()) {
			log.Printf("[DEBUG] Deleting Connection: %s", connection.GetName())
			_, resp, err := fabric.ConnectionsApi.DeleteConnectionByUuid(ctx, connection.GetUuid()).Execute()
			if resp.StatusCode == http.StatusForbidden || resp.StatusCode == http.StatusNotFound {
				errs = append(errs, fmt.Errorf("error deleting fabric connection: %s", err))
			}
		}
	}

	return errors.Join(errs...)
}
