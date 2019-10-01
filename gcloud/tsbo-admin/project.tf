provider "google" {
  credentials = "${file("~/.google/tsbo-admin-e5b99d056761.json")}"
  region      = var.region
}

data "google_billing_account" "billing_account" {
  billing_account = var.billing_account
  open            = true
}

data "google_organization" "organization" {
  domain = "tsbo.me"
}

resource "google_project" "project" {
  name       = var.project_name
  project_id = var.project_name
  org_id     = "${data.google_organization.organization.id}"

  billing_account = "${data.google_billing_account.billing_account.id}"
}

resource "google_project_services" "services" {
  project = "${google_project.project.project_id}"
  services = [
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "bigquery-json.googleapis.com",
    "bigquery-json.googleapis.com",
    "bigquerystorage.googleapis.com",
    "cloudapis.googleapis.com",
    "cloudbilling.googleapis.com",
    "clouddebugger.googleapis.com",
    "cloudtrace.googleapis.com",
    "compute.googleapis.com",
    "datastore.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "oslogin.googleapis.com",
    "servicemanagement.googleapis.com",
    "serviceusage.googleapis.com",
    "sql-component.googleapis.com",
    "storage-api.googleapis.com",
    "storage-component.googleapis.com",
    "dns.googleapis.com"
  ]
}
