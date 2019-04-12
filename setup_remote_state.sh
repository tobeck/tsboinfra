#!/usr/bin/env bash

gsutil mb -p ${TF_ADMIN} gs://${TF_ADMIN}

cat > backend.tf << EOF
terraform {
  backend "gcs" {
    bucket  = "${TF_ADMIN}"
      prefix  = "terraform/state"
        project = "${TF_ADMIN}"
  }
}
EOF

gsutil versioning set on gs://${TF_ADMIN}
