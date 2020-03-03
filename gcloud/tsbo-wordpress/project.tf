# tsbo-wordpress project level resources.

provider "google" {
  credentials = "${file("~/.google/tsbo-admin-e5b99d056761.json")}"
  region      = "europe-north1"
}

data "google_billing_account" "billing_account" {
  billing_account = var.billing_account
  open            = true
}

data "google_organization" "organization" {
  domain = "tsbo.me"
}

resource "google_project" "project" {
  name            = var.project_name
  project_id      = var.project_name
  org_id          = "${data.google_organization.organization.id}"
  billing_account = "${data.google_billing_account.billing_account.id}"
}

output "project_id" {
  value = "${google_project.project.project_id}"
}
