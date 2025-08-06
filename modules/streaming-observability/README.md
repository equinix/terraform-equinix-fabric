# Fabric Streaming Observability SubModule

The Fabric Streaming Observability Module will:
1. Create a Fabric Stream
   * **NOTE: Fabric streams have a max limit of 3 subscriptions per stream.
     So if all subscriptions available in this module are leveraged then a 
     2nd Fabric Stream will be created to accommodate the extra subscriptions.
     This does have billing considerations to take into account as the 2nd
     Fabric Stream will be billed to your account as well**
2. Create Fabric Stream Subscriptions based on the variable values input into
   the module at creation
   * Available subscription types in this module at this time are:
     [Splunk, Slack, MicrosoftTeams, PagerDuty, Datadog]
3. Exposes outputs for each of the Fabric Resources created in this module
   * View outputs.tf file below for details on how the resource outputs are
     provided based on their creation

Please refer to the stream* examples in this module's registry for more details on how to leverage the submodule.

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
