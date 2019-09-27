# tsbo-gitlab compute resource.

resource "google_compute_instance" "instance" {
  description  = "GCE instance hosting gitlab."
  project      = "${google_project.project.project_id}"
  zone         = var.zone
  name         = "${var.project_name}-instance"
  machine_type = "n1-standard-1"
  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
      type  = "pd-standard"
      size  = 10
    }
  }
  network_interface {
    network = "${var.project_name}-network"
    access_config {
    }
  }
  attached_disk {
    source      = "${google_compute_disk.gitlab-data.self_link}"
    device_name = "${var.project_name}-data"
  }

  metadata = {
    user-data = data.template_file.user-data.rendered
  }

  tags = ["web", "ssh"]
}

data "template_file" "user-data" {
  template = file("${path.module}/user-data")
  vars = {
    disk_name = "${google_compute_disk.gitlab-data.name}"
  }
}

resource "google_compute_disk" "gitlab-data" {
  description = "GCE disk mounted to gitlab instance to persist data."
  name        = "${var.project_name}-data"
  project     = "${google_project.project.project_id}"
  zone        = var.zone
  type        = "pd-standard"
  size        = 10
}
