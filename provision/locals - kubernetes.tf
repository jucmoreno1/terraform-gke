locals {
  kubernetes_service_accounts = {
    "harness-service-account" = {
      namespace = "default"
    }
  }
  kubernetes_roles = {
    "harness-admin" = {
      role = {
        api_group = "rbac.authorization.k8s.io"
        kind      = "ClusterRole"
        name      = "cluster-admin"
      }
      subject = {
        kind      = "ServiceAccount"
        name      = "harness-service-account"
        namespace = "default"
      }
    }
    "ccm-visibility-clusterrolebinding" = {
      role = {
        api_group = "rbac.authorization.k8s.io"
        kind      = "ClusterRole"
        name      = "ccm-visibility-clusterrole"
      }
      subject = {
        kind      = "ServiceAccount"
        name      = "harness-service-account"
        namespace = "default"
      }
    }
  }
  kubernetes_secrets = {
    "harness-service-account-token" = {
      service_account = "harness-service-account"
    }
  }
}
