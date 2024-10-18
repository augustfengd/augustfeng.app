data "google_client_config" "provider" {}

data "google_project" "project" {}

resource "google_compute_firewall" "ingress" {
  allow {
    ports = ["443"]

    protocol = "tcp"
  }

  name = "augustfeng-app-https"

  network = "default"

  source_ranges = ["0.0.0.0/0"]

  target_service_accounts = ["${google_service_account.augustfeng-app.email}"]
}

resource "google_container_cluster" "augustfeng-app" {
  initial_node_count = 1

  location = "us-east1-b"

  name = "augustfeng-app"

  node_config {
    disk_size_gb = "10"

    disk_type = "pd-standard"

    machine_type = "e2-micro"

    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

    service_account = google_service_account.augustfeng-app.email
  }

  workload_identity_config {
    workload_pool = "${data.google_project.project.project_id}.svc.id.goog"
  }
}

resource "google_container_node_pool" "e2-medium" {
  cluster = google_container_cluster.augustfeng-app.id

  name = "e2-medium-pool"

  node_config {
    disk_size_gb = "10"

    disk_type = "pd-standard"

    machine_type = "e2-medium"

    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

    service_account = google_service_account.augustfeng-app.email

    spot = true
  }

  node_count = 1
}

resource "google_container_node_pool" "e2-micro" {
  cluster = google_container_cluster.augustfeng-app.id

  name = "e2-micro-pool"

  node_config {
    disk_size_gb = "10"

    disk_type = "pd-standard"

    machine_type = "e2-micro"

    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

    service_account = google_service_account.augustfeng-app.email

    spot = true
  }

  node_count = 0
}

resource "google_container_node_pool" "e2-small" {
  cluster = google_container_cluster.augustfeng-app.id

  name = "e2-small-pool"

  node_config {
    disk_size_gb = "10"

    disk_type = "pd-standard"

    machine_type = "e2-small"

    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

    service_account = google_service_account.augustfeng-app.email

    spot = true
  }

  node_count = 0
}

resource "google_dns_managed_zone" "augustfeng-app" {
  dns_name = "augustfeng.app."

  force_destroy = true

  name = "augustfeng-app"
}

resource "google_dns_record_set" "augustfeng-app" {
  lifecycle {
    ignore_changes = [rrdatas]
  }

  managed_zone = google_dns_managed_zone.augustfeng-app.name

  name = google_dns_managed_zone.augustfeng-app.dns_name

  rrdatas = ["0.0.0.0"]

  ttl = 300

  type = "A"
}

resource "google_project_iam_member" "ci-cd-pipeline-0" {
  member = "serviceAccount:${google_service_account.ci-cd-pipeline.email}"

  project = "augustfengd"

  role = "roles/container.admin"
}

resource "google_project_iam_member" "domain-controller-0" {
  member = "serviceAccount:${google_service_account.domain-controller.email}"

  project = "augustfengd"

  role = "roles/dns.admin"
}

resource "google_service_account" "augustfeng-app" {
  account_id = "augustfeng-app"

  display_name = "augustfeng-app"
}

resource "google_service_account" "ci-cd-pipeline" {
  account_id = "ci-cd-pipeline"

  display_name = "ci-cd-pipeline"
}

resource "google_service_account" "domain-controller" {
  account_id = "domain-controller"

  display_name = "domain-controller"
}

resource "google_service_account_iam_member" "workload-identity-domain-controller" {
  member = "serviceAccount:${data.google_project.project.project_id}.svc.id.goog[system-ingress/domain-controller]"

  role = "roles/iam.workloadIdentityUser"

  service_account_id = google_service_account.domain-controller.name
}

resource "google_service_account_key" "ci-cd-pipeline" {
  service_account_id = google_service_account.ci-cd-pipeline.name
}

provider "google" {
  project = "augustfengd"
}
