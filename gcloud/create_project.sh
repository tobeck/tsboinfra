#!/usr/bin/env bash
#
# Create a terraform admin google cloud project and link it to a billing account.
#

set -euo pipefail

# Create the terraform admin project
gcloud projects create "${TF_ADMIN_PROJECT}" --organization="${TF_VAR_ORG_ID}" --set-as-default

# Link billing with the terraform admin project
gcloud beta billing projects link "${TF_ADMIN_PROJECT}" --billing-account="${TF_VAR_BILLING_ACCOUNT}"