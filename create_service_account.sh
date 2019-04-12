#!/usr/bin/env bash

# Create service account.
gcloud iam service-accounts create terraform --display-name "Terraform admin account"

gcloud iam service-accounts keys create ${TF_CREDS} --iam-account terraform@${TF_ADMIN}.iam.gserviceaccount.com

# Grant permissions to the new service account.
gcloud projects add-iam-policy-binding ${TF_ADMIN} --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com --role roles/viewer

gcloud projects add-iam-policy-binding ${TF_ADMIN} --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com --role roles/storage.admin

# Grant the service account permission to create projects and assign billing account.

gcloud organizations add-iam-policy-binding ${TF_VAR_ORG_ID} --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com --role roles/resourcemanager.projectCreator

gcloud organizations add-iam-policy-binding ${TF_VAR_ORG_ID} --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com --role roles/billing.user

