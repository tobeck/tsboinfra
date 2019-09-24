provider "google" {
  region = "${var.region}"
}

data "google_billing_account" "billing_account" {
  billing_account = "012242-C85D66-4DCB94"
  open            = true
}

data "google_organization" "organization" {
  domain = "tsbo.me"
}

resource "google_project" "project" {
  name       = "tsbo-terraform-admin"
  project_id = "tsbo-terraform-admin"
  org_id     = "${data.google_organization.organization.id}"

  billing_account = "${data.google_billing_account.billing_account.id}"
}
