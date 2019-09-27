resource "google_dns_managed_zone" "tsbo-zone" {
  name        = "tsbo-zone"
  dns_name    = "tsbo.me."
  description = "The tsbo DNS zone"
}
