#!/usr/bin/env bash
#
# Create a new google cloud project and link it to a billing account.
#

set -euo pipefail

gcloud projects create ${TF_ADMIN} --organization=${TF_VAR_ORG_ID} --set-as-default

gcloud beta billing projects link ${TF_ADMIN} --billing-account=${TF_VAR_BILLING_ACCOUNT}
