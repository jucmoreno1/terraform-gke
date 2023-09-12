resource "kubernetes_service_account_v1" "sa" {
  for_each = var.kubernetes_service_accounts
  metadata {
    name      = each.key
    namespace = each.value.namespace
  }
}

resource "kubernetes_cluster_role_binding" "role_binding" {
  for_each = var.kubernetes_roles
  metadata {
    name = each.key
  }
  role_ref {
    api_group = each.value.role.api_group
    kind      = each.value.role.kind
    name      = each.value.role.name
  }
  subject {
    kind      = each.value.subject.kind
    name      = each.value.subject.name
    namespace = each.value.subject.namespace
  }
}

resource "kubernetes_secret_v1" "sa" {
  for_each = var.kubernetes_secrets
  metadata {
    name = each.key
    annotations = {
      "kubernetes.io/service-account.name" = each.value.service_account
    }
  }
  type = "kubernetes.io/service-account-token"
}
