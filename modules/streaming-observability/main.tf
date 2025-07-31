
# Conditional logic determining if a second stream should be created to allow for the total count of subscriptions
locals {
  webhook_count = (var.webhook_event_uri != "" || var.webhook_metric_uri != "") ? 1 : 0
  number_of_subscriptions = [
    for sub in [var.splunk_uri, var.slack_uri, var.pagerduty_host, var.msteams_uri, var.datadog_host, var.servicenow_host] : sub if sub != ""
  ]
  total_subscriptions = length(local.number_of_subscriptions) + local.webhook_count
  second_stream = local.total_subscriptions > 3 ? true : false
}

# Stream Creation -----------------------------------------------------
resource "equinix_fabric_stream" "stream1" {
  type        = "TELEMETRY_STREAM"
  name        = var.stream_name
  description = var.stream_description
}

resource "equinix_fabric_stream" "stream2" {
  count       = local.second_stream ? 1 : 0
  type        = "TELEMETRY_STREAM"
  name        = join("-", [var.stream_name, "2"])
  description = var.stream_description
}

# Stream Subscription for Splunk --------------------------------------
resource "equinix_fabric_stream_subscription" "splunk" {
  count       = var.splunk_uri != "" ? 1 : 0
  type        = "STREAM_SUBSCRIPTION"
  name        = var.splunk_name
  description = var.splunk_description
  stream_id   = equinix_fabric_stream.stream1.id
  enabled     = var.splunk_enabled
  event_selector = {
    include = var.splunk_event_selections != [] ? var.splunk_event_selections : null
    except  = var.splunk_event_exceptions != [] ? var.splunk_event_exceptions : null
  }
  metric_selector = {
    include = var.splunk_metric_selections != [] ? var.splunk_metric_selections : null
    except  = var.splunk_metric_exceptions != [] ? var.splunk_metric_exceptions : null
  }
  sink = {
    type = "SPLUNK_HEC"
    uri  = var.splunk_uri
    settings = {
      source       = var.splunk_source
      event_index  = var.splunk_event_index
      metric_index = var.splunk_metric_index
    }
    credential = {
      type         = "ACCESS_TOKEN"
      access_token = var.splunk_access_token
    }
  }
}

# Stream Subscription for Slack --------------------------------------
resource "equinix_fabric_stream_subscription" "slack" {
  count       = var.slack_uri != "" ? 1 : 0
  type        = "STREAM_SUBSCRIPTION"
  name        = var.slack_name
  description = var.slack_description
  stream_id   = equinix_fabric_stream.stream1.id
  enabled     = var.slack_enabled
  event_selector = {
    include = var.slack_event_selections != [] ? var.slack_event_selections : null
    except  = var.slack_event_exceptions != [] ? var.slack_event_exceptions : null
  }
  metric_selector = {
    include = var.slack_metric_selections != [] ? var.slack_metric_selections : null
    except  = var.slack_metric_exceptions != [] ? var.slack_metric_exceptions : null
  }
  sink = {
    type = "SLACK"
    uri  = var.slack_uri
  }
}

# Stream Subscription for Pager Duty --------------------------------------
resource "equinix_fabric_stream_subscription" "pagerduty" {
  count       = var.pagerduty_host != "" ? 1 : 0
  type        = "STREAM_SUBSCRIPTION"
  name        = var.pagerduty_name
  description = var.pagerduty_description
  stream_id   = equinix_fabric_stream.stream1.id
  enabled     = var.pagerduty_enabled
  event_selector = {
    include = var.pagerduty_event_selections != [] ? var.pagerduty_event_selections : null
    except  = var.pagerduty_event_exceptions != [] ? var.pagerduty_event_exceptions : null
  }
  metric_selector = {
    include = var.pagerduty_metric_selections != [] ? var.pagerduty_metric_selections : null
    except  = var.pagerduty_metric_exceptions != [] ? var.pagerduty_metric_exceptions : null
  }
  sink = {
    type = "PAGERDUTY"
    host = var.pagerduty_host
    settings = {
      change_uri = var.pagerduty_change_uri
      alert_uri  = var.pagerduty_alert_uri
    }
    credential = {
      type            = "INTEGRATION_KEY"
      integration_key = var.pagerduty_integration_key
    }
  }
}

# Stream Subscription for DataDog --------------------------------------
resource "equinix_fabric_stream_subscription" "datadog" {
  count       = var.datadog_host != "" ? 1 : 0
  type        = "STREAM_SUBSCRIPTION"
  name        = var.datadog_name
  description = var.datadog_description
  stream_id   = local.second_stream ? equinix_fabric_stream.stream2[0].id : equinix_fabric_stream.stream1.id
  enabled     = var.datadog_enabled
  event_selector = {
    include = var.datadog_event_selections != [] ? var.datadog_event_selections : null
    except  = var.datadog_event_exceptions != [] ? var.datadog_event_exceptions : null
  }
  metric_selector = {
    include = var.datadog_metric_selections != [] ? var.datadog_metric_selections : null
    except  = var.datadog_metric_exceptions != [] ? var.datadog_metric_exceptions : null
  }
  sink = {
    type = "DATADOG"
    host = var.datadog_host
    settings = {
      source          = "Equinix"
      application_key = var.datadog_application_key
      event_uri       = var.datadog_event_uri
      metric_uri      = var.datadog_metric_uri
    }
    credential = {
      type    = "API_KEY"
      api_key = var.datadog_api_key
    }
  }
}

# Stream Subscription for Microsoft Teams --------------------------------------
resource "equinix_fabric_stream_subscription" "msteams" {
  count       = var.msteams_uri != "" ? 1 : 0
  type        = "STREAM_SUBSCRIPTION"
  name        = var.msteams_name
  description = var.msteams_description
  stream_id   = local.second_stream ? equinix_fabric_stream.stream2[0].id : equinix_fabric_stream.stream1.id
  enabled     = var.msteams_enabled
  event_selector = {
    include = var.msteams_event_selections != [] ? var.msteams_event_selections : null
    except  = var.msteams_event_exceptions != [] ? var.msteams_event_exceptions : null
  }
  metric_selector = {
    include = var.msteams_metric_selections != [] ? var.msteams_metric_selections : null
    except  = var.msteams_metric_exceptions != [] ? var.msteams_metric_exceptions : null
  }
  sink = {
    type = "TEAMS"
    uri  = var.msteams_uri
  }
}

# Stream Subscription for ServiceNow --------------------------------------
resource "equinix_fabric_stream_subscription" "servicenow" {
  count       = var.servicenow_host != "" ? 1 : 0
  type        = "STREAM_SUBSCRIPTION"
  name        = var.servicenow_name
  description = var.servicenow_description
  stream_id   = local.second_stream ? equinix_fabric_stream.stream2[0].id : equinix_fabric_stream.stream1.id
  enabled     = var.servicenow_enabled
  event_selector = {
    include = var.servicenow_event_selections != [] ? var.servicenow_event_selections : null
    except  = var.servicenow_event_exceptions != [] ? var.servicenow_event_exceptions : null
  }
  metric_selector = {
    include = var.servicenow_metric_selections != [] ? var.servicenow_metric_selections : null
    except  = var.servicenow_metric_exceptions != [] ? var.servicenow_metric_exceptions : null
  }
  sink = {
    type = "SERVICENOW"
    host = var.servicenow_host
    settings = {
      source = var.servicenow_source
    }
    credential = {
      type = "USERNAME_PASSWORD"
      username = var.servicenow_username
      password = var. servicenow_password
    }
  }
}

# Stream Subscription for Webhook --------------------------------------
resource "equinix_fabric_stream_subscription" "webhook" {
  count       = local.webhook_count
  type        = "STREAM_SUBSCRIPTION"
  name        = var.webhook_name
  description = var.webhook_description
  stream_id   = local.second_stream ? equinix_fabric_stream.stream2[0].id : equinix_fabric_stream.stream1.id
  enabled = var.webhook_enabled
  event_selector = {
    include = var.webhook_event_selections != [] ? var.webhook_event_selections : null
    except  = var.webhook_event_exceptions != [] ? var.webhook_event_exceptions : null
  }
  metric_selector = {
    include = var.webhook_metric_selections != [] ? var.webhook_metric_selections : null
    except  = var.webhook_metric_exceptions != [] ? var.webhook_metric_exceptions : null
  }
  sink = {
    type = "WEBHOOK"
    settings = {
      format     = var.webhook_format
      event_uri  = var.webhook_event_uri != "" ? var.webhook_event_uri : null
      metric_uri = var.webhook_metric_uri != "" ? var.webhook_metric_uri : null
    }
  }
}