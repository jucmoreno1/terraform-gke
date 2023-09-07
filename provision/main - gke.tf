# GKE cluster
data "google_container_engine_versions" "gke_version" {
  location       = var.region
  version_prefix = var.version_prefix
}

resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = "default"
  subnetwork = "default"

  resource_labels = merge(
    var.cluster_labels,
    {
      env     = var.project_id
      cluster = var.cluster_name
    }
  )
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name     = google_container_cluster.primary.name
  location = var.region
  cluster  = google_container_cluster.primary.name

  version    = data.google_container_engine_versions.gke_version.release_channel_latest_version["STABLE"]
  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = merge(
      var.cluster_labels,
      {
        env     = var.project_id
        cluster = var.cluster_name
      }
    )

    # preemptible  = true
    machine_type = var.machine_type
    tags         = var.tags
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}

data "google_client_config" "default" {}


provider "kubernetes" {
  host                   = "https://${google_container_cluster.primary.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
}

resource "kubernetes_service_account" "sa" {
  count = var.store_credentials_harness ? 1 : 0
  metadata {
    name      = var.cluster_name
    namespace = "default"
  }
}

resource "kubernetes_token_request_v1" "sa" {
  count = var.store_credentials_harness ? 1 : 0
  metadata {
    name      = kubernetes_service_account.sa.0.metadata.0.name
    namespace = "default"
  }
  spec {
    expiration_seconds = 3600
    audiences = [
      "api"
    ]
  }
}

resource "kubernetes_cluster_role_binding" "example" {
  count = var.store_credentials_harness ? 1 : 0
  metadata {
    name = var.cluster_name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.sa.0.metadata.0.name
    namespace = "default"
  }
}
