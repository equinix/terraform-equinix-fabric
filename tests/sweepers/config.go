package sweepers

import (
	"context"
	"fmt"
	"net/http"
	"net/url"
	"os"
	"strconv"
	"strings"
	"time"

	"github.com/equinix/equinix-sdk-go/services/fabricv4"

	"github.com/equinix/oauth2-go"
	"github.com/hashicorp/go-retryablehttp"
)

const (
	endpointEnvVar      = "EQUINIX_API_ENDPOINT"
	clientIDEnvVar      = "TF_VAR_equinix_client_id"
	clientSecretEnvVar  = "TF_VAR_equinix_client_secret"
	clientTimeoutEnvVar = "EQUINIX_API_TIMEOUT"
)

const (
	defaultBaseURL            = "https://api.equinix.com"
	defaultTimeout            = 30
	cannotConvertTimeoutToInt = "cannot convert value of '%s' env variable to int"
	missingFabricSecrets      = "missing fabric clientId - %s, and clientSecret - %s"
)

var (
	fabricTestResourceSuffixes = []string{"_PFCR", "_PNFV", "_PPDS"}
)

func isSweepableFabricTestResource(resourceName string) bool {
	for _, suffix := range fabricTestResourceSuffixes {
		if strings.HasSuffix(resourceName, suffix) {
			return true
		}
	}
	return false
}

func getWithDefault(varName string, defaultValue string) string {
	if v := os.Getenv(varName); v != "" {
		return v
	}
	return defaultValue
}

func newFabricClient() (*fabricv4.APIClient, error) {
	ctx := context.Background()
	endpoint := getWithDefault(endpointEnvVar, defaultBaseURL)
	clientId := getWithDefault(clientIDEnvVar, "")
	clientSecret := getWithDefault(clientSecretEnvVar, "")
	if clientId == "" || clientSecret == "" {
		return nil, fmt.Errorf(missingFabricSecrets, clientIDEnvVar, clientSecretEnvVar)
	}

	clientTimeout := getWithDefault(clientTimeoutEnvVar, strconv.Itoa(defaultTimeout))
	clientTimeoutInt, err := strconv.Atoi(clientTimeout)
	if err != nil {
		return nil, fmt.Errorf(cannotConvertTimeoutToInt, clientTimeoutEnvVar)
	}

	var authClient *http.Client
	authConfig := oauth2.Config{
		ClientID:     clientId,
		ClientSecret: clientSecret,
		BaseURL:      endpoint,
	}
	authClient = authConfig.New(ctx)

	retryClient := retryablehttp.NewClient()
	retryClient.HTTPClient.Transport = authClient.Transport
	retryClient.HTTPClient.Timeout = time.Duration(clientTimeoutInt) * time.Second
	retryClient.RetryWaitMin = time.Second
	standardClient := retryClient.StandardClient()

	baseURL, _ := url.Parse(endpoint)

	configuration := fabricv4.NewConfiguration()
	configuration.Servers = fabricv4.ServerConfigurations{
		fabricv4.ServerConfiguration{
			URL: baseURL.String(),
		},
	}
	configuration.HTTPClient = standardClient
	client := fabricv4.NewAPIClient(configuration)

	client.GetConfig().UserAgent = fmt.Sprintf("tf-fabric-modules-terratests %v", client.GetConfig().UserAgent)

	return client, nil
}
