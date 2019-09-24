#!/usr/bin/env bash

SERVICE_ACCOUNT_NAME="tsbo-admin-terraform"

# Create service account.
gcloud iam service-accounts create "${SERVICE_ACCOUNT_NAME}" --display-name "Terraform admin account"
gcloud iam service-accounts keys create "${TF_ADMIN_CREDS}" --iam-account "${SERVICE_ACCOUNT_NAME}"@"${TF_ADMIN_PROJECT}".iam.gserviceaccount.com

# Grant permissions to the new service account.
gcloud projects add-iam-policy-binding "${TF_ADMIN_PROJECT}" --member serviceAccount:"${SERVICE_ACCOUNT_NAME}"@"${TF_ADMIN_PROJECT}".iam.gserviceaccount.com --role roles/viewer
gcloud projects add-iam-policy-binding "${TF_ADMIN_PROJECT}" --member serviceAccount:"${SERVICE_ACCOUNT_NAME}"@"${TF_ADMIN_PROJECT}".iam.gserviceaccount.com --role roles/storage.admin

# Grant the service account permission to create projects and assign billing account.
gcloud organizations add-iam-policy-binding "${TF_VAR_ORG_ID}" --member serviceAccount:"${SERVICE_ACCOUNT_NAME}"@"${TF_ADMIN_PROJECT}".iam.gserviceaccount.com --role roles/resourcemanager.projectCreator
gcloud organizations add-iam-policy-binding "${TF_VAR_ORG_ID}" --member serviceAccount:"${SERVICE_ACCOUNT_NAME}"@"${TF_ADMIN_PROJECT}".iam.gserviceaccount.com --role roles/billing.user