resource "google_dns_managed_zone" "tsbo-zone" {
  name        = "tsbo-zone"
  dns_name    = "tsbo.me."
  description = "The tsbo DNS zone"
  project     = "${google_project.project.project_id}"
}

resource "google_dns_record_set" "mx" {
  name         = "${google_dns_managed_zone.tsbo-zone.dns_name}"
  managed_zone = "${google_dns_managed_zone.tsbo-zone.name}"
  type         = "MX"
  ttl          = 3600
  project      = "${google_project.project.project_id}"

  rrdatas = [
    "1 aspmx.l.google.com.",
    "5 alt1.aspmx.l.google.com.",
    "5 alt2.aspmx.l.google.com.",
    "10 alt3.aspmx.l.google.com.",
    "10 alt4.aspmx.l.google.com."
  ]
}
