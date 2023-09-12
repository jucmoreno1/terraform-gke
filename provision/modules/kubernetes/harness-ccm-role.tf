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
