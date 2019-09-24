# tsbo-gitlab project level resources.

provider "google" {
  credentials = "${file("~/.google/tsbo-admin-e5b99d056761.json")}"
  region      = "europe-north1"
}

data "google_billing_account" "billing_account" {
  billing_account = "012242-C85D66-4DCB94"
  open            = true
}

data "google_organization" "organization" {
  domain = "tsbo.me"
}

resource "google_project" "project" {
  name            = "tsbo-gitlab"
  project_id      = "tsbo-gitlab"
  org_id          = "${data.google_organization.organization.id}"
  billing_account = "${data.google_billing_account.billing_account.id}"
}

resource "google_project_services" "project_services" {
  project = "${google_project.project.project_id}"
  services = [
    "compute.googleapis.com",
    "oslogin.googleapis.com"
  ]
}

output "project_id" {
  value = "${google_project.project.project_id}"
}
