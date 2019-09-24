#!/usr/bin/env bash

gsutil mb -p "${TF_ADMIN_PROJECT}" gs://"${TF_ADMIN_PROJECT}"

cat > backend.tf << EOF
terraform {
  backend "gcs" {
    bucket  = "${TF_ADMIN_PROJECT}"
      prefix  = "terraform/state"
        project = "${TF_ADMIN_PROJECT}"
  }
}
EOF

# Enable versioning for the terraform remote state file.
gsutil versioning set on gs://"${TF_ADMIN_PROJECT}"
