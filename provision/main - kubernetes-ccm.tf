resource "kubernetes_role_v1" "ccm" {
  count = var.enable_harness_ccm_connector ? 1 : 0
  metadata {
    name = "ccm-visibility-clusterrole"
  }

  rule {
    api_groups = [""]
    resources = [
      "pods",
      "nodes",
      "nodes/proxy",
      "events",
      "namespaces",
      "persistentvolumes",
      "persistentvolumeclaims"
    ]
    verbs = [
      "get",
      "list",
      "watch"
    ]
  }
  rule {
    api_groups = [
      "apps",
      "extensions"
    ]
    resources = [
      "statefulsets",
      "deployments",
      "daemonsets",
      "replicasets"
    ]
    verbs = [
      "get",
      "list",
      "watch"
    ]
  }
  rule {
    api_groups = [
      "batch"
    ]
    resources = [
      "jobs",
      "cronjobs"
    ]
    verbs = [
      "get",
      "list",
      "watch"
    ]
  }
  rule {
    api_groups = [
      "metrics.k8s.io"
    ]
    resources = [
      "pods",
      "nodes"
    ]
    verbs = [
      "get",
      "list"
    ]
  }
  rule {
    api_groups = [
      "storage.k8s.io"
    ]
    resources = [
      "storageclasses"
    ]
    verbs = [
      "get",
      "list",
      "watch"
    ]
  }
}

resource "kubernetes_cluster_role_binding" "ccm" {
  count = var.enable_harness_ccm_connector ? 1 : 0
  metadata {
    name = "ccm-visibility-clusterrolebinding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_role_v1.ccm.0.metadata.0.name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account_v1.sa.0.metadata.0.name
    namespace = "default"
  }
}
