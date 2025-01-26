data "google_client_config" "provider" {}

data "google_project" "project" {}

resource "google_compute_firewall" "ingress" {
  name                    = "augustfeng-app-https"
  network                 = "default"
  source_ranges           = ["0.0.0.0/0"]
  target_service_accounts = ["${google_service_account.augustfeng-app.email}"]

  allow {
    ports    = ["443"]
    protocol = "tcp"
  }
}

resource "google_container_cluster" "augustfeng-app" {
  name               = "augustfeng-app"
  location           = "us-east1-b"
  initial_node_count = 1

  node_config {
    disk_size_gb    = "10"
    disk_type       = "pd-standard"
    machine_type    = "e2-micro"
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
    service_account = google_service_account.augustfeng-app.email
  }

  workload_identity_config {
    workload_pool = "${data.google_project.project.project_id}.svc.id.goog"
  }
}

resource "google_service_account" "augustfeng-app" {
  account_id   = "augustfeng-app"
  display_name = "augustfeng-app"
}
