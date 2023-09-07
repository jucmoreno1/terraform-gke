locals {
  secrets = var.store_credentials_harness ? {
    "${var.cluster_name}_cluster_ca_certificate" = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
    "${var.cluster_name}_service_account_token"  = kubernetes_token_request_v1.sa.0.token
  } : {}




  cluster = var.store_credentials_harness ? {
    "${var.cluster_name}" = {
      description        = "terraform generated k8s connector"
      tags               = []
      project_id         = ""
      org_id             = ""
      delegate_selectors = []
      service_account = {
        credentials = {
          master_url                = "https://${google_container_cluster.primary.endpoint}"
          service_account_token_ref = "account.${harness_platform_secret_text.inline["${var.cluster_name}_service_account_token"].identifier}"
        }
      }
      username_password     = {}
      inherit_from_delegate = {}
    }
  } : {}
}
