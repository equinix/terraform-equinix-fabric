#!/usr/bin/env bash
set -e

BASE_NAME="test-connection"
VARS_FILE="terraform.tfvars.json"

VD_UUIDS=(
    "9f5bd71c-84ee-4f45-8856-c147881f4339"
    "9829ecda-f0cb-4bc2-974d-9a499e1bb6fa"
    "d88f1aae-ce64-4fb8-8159-bf3ade75784f"
)

terraform init

for i in "${!VD_UUIDS[@]}"; do
  CONNECTION_NAME="${BASE_NAME}-$((i+1))"
  VD_UUID="${VD_UUIDS[$i]}"
  WORKSPACE="conn-$((i+1))"

  echo "Creating connection in workspace: $WORKSPACE"

  terraform workspace select "$WORKSPACE" 2>/dev/null \
    || terraform workspace new "$WORKSPACE"

  jq --arg name "$CONNECTION_NAME" \
     --arg uuid "$VD_UUID" \
     '.connection_name = $name | .aside_vd_uuid = $uuid' \
     "$VARS_FILE" > tmp.json && mv tmp.json "$VARS_FILE"

  terraform apply -auto-approve -var-file="$VARS_FILE"
done