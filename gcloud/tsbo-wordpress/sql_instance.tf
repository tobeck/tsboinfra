# tsbo-wordpress compute resoure.

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "master" {
  name             = "tsbo-wordpress-db-${random_id.db_name_suffix.hex}"
  database_version = "MYSQL_5_6"
  region           = var.zone
  project          = "${google_project.project.project_id}"

  settings {
    tier = "db-f1-micro"
  }
}
