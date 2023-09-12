data "google_client_config" "default" {}

data "google_service_account" "sa" {
  account_id = var.gcp_service_account
}

# GKE cluster
data "google_container_engine_versions" "gke_version" {
  location       = var.gcp_region
  version_prefix = var.gke_version_prefix
}

resource "google_container_cluster" "primary" {
  name     = var.gke_cluster_name
  location = var.gcp_region

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = var.gcp_network
  subnetwork = var.gcp_subnetwork

  resource_labels = merge(
    var.gke_cluster_labels,
    {
      env     = var.gcp_project_id
      cluster = var.gke_cluster_name
    }
  )
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name     = "${google_container_cluster.primary.name}-primary"
  location = var.gcp_region
  cluster  = google_container_cluster.primary.name

  version    = data.google_container_engine_versions.gke_version.release_channel_latest_version["STABLE"]
  node_count = var.gke_num_nodes

  node_locations = [
    "${var.gcp_region}-c"
  ]

  node_config {
    service_account = data.google_service_account.sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = merge(
      var.gke_cluster_labels,
      {
        env     = var.gcp_project_id
        cluster = var.gke_cluster_name
      }
    )

    # preemptible  = true
    machine_type = var.gcp_machine_type
    tags         = var.tags
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
