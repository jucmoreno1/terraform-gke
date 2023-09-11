provider "kubernetes" {
  host                   = "https://${google_container_cluster.primary.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
}

resource "kubernetes_service_account_v1" "sa" {
  count = var.enable_harness_k8s_connector ? 1 : 0
  metadata {
    name      = "harness-service-account"
    namespace = "default"
  }
}

resource "kubernetes_cluster_role_binding" "sa" {
  count = var.enable_harness_k8s_connector ? 1 : 0
  metadata {
    name = "harness-admin"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account_v1.sa.0.metadata.0.name
    namespace = "default"
  }
}

resource "kubernetes_secret_v1" "sa" {
  count = var.enable_harness_k8s_connector ? 1 : 0
  metadata {
    name = "harness-service-account-token"
    annotations = {
      "kubernetes.io/service-account.name" = "harness-service-account"
    }
  }
  type = "kubernetes.io/service-account-token"
}
