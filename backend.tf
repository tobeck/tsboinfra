terraform {
  backend "gcs" {
    bucket  = "tsbo-terraform-admin"
      prefix  = "terraform/state"
        project = "tsbo-terraform-admin"
  }
}
