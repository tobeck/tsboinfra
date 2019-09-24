resource "google_compute_network" "vpc_network" {
  description = "GCE VPC network resource for the project."
  name        = "${var.project_name}-network"
  project     = "${google_project.project.project_id}"
}

resource "google_compute_firewall" "ssh_ingress" {
  description = "GCE VPC ports associated with SSH ingress."
  name        = "${var.project_name}-ssh-ingress"
  network     = "${var.project_name}-network"
  project     = "${google_project.project.project_id}"

  allow {
    protocol = "tcp"

    ports = [
      "22",
      "2222",
    ]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}

resource "google_compute_firewall" "web_ingress" {
  description = "GCE VPC ports associated with web ingress."
  name        = "${var.project_name}-web-ingress"
  network     = "${var.project_name}-network"
  project     = "${google_project.project.project_id}"

  allow {
    protocol = "tcp"

    ports = [
      "80",
      "443",
    ]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web"]
}

output "vpc-name" {
  value = "${google_compute_network.vpc_network}"
}
