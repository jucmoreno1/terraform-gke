output "gke" {
  value = {
    cluster_ca_certificate = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
    endpoint               = google_container_cluster.primary.endpoint
    token                  = data.google_client_config.default.access_token
    name                   = google_container_cluster.primary.name
  }
}

