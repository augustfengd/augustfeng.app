resource "kubernetes_namespace" "blog" {
  depends_on = [google_container_cluster.augustfeng-app]

  metadata {
    name = "blog"
  }
}

resource "kubernetes_namespace" "system-ingress" {
  depends_on = [google_container_cluster.augustfeng-app]

  metadata {
    name = "system-ingress"
  }
}

resource "kubernetes_namespace" "system-monitoring" {
  depends_on = [google_container_cluster.augustfeng-app]

  metadata {
    name = "system-monitoring"
  }
}

provider "kubernetes" {
  cluster_ca_certificate = base64decode(google_container_cluster.augustfeng-app.master_auth[0].cluster_ca_certificate)
  host                   = "https://${google_container_cluster.augustfeng-app.endpoint}"
  token                  = data.google_client_config.provider.access_token
}
