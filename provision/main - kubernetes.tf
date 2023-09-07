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
