provider "google" {
  region = "${var.region}"
}

data "google_billing_account" "billing_account" {
  billing_account = "${var.billing_account}"
  open            = true
}

data "google_organization" "organization" {
  domain = "tsbo.me"
}

resource "google_project" "project" {
  name       = "tsbo-admin"
  project_id = "tsbo-admin"
  org_id     = "${data.google_organization.organization.id}"

  billing_account = "${data.google_billing_account.billing_account.id}"
}
