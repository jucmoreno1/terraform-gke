resource "harness_platform_connector_kubernetes" "connector" {
  depends_on         = [harness_platform_secret_text.inline]
  for_each           = var.kubernetes_connector
  identifier         = lower(replace(each.key, "/[\\s-.]/", "_"))
  name               = each.key
  description        = each.value.description
  tags               = each.value.tags
  project_id         = each.value.project_id
  org_id             = each.value.org_id
  delegate_selectors = each.value.delegate_selectors

  dynamic "service_account" {
    for_each = each.value.service_account
    content {
      master_url                = service_account.value.master_url
      service_account_token_ref = "account.${harness_platform_secret_text.inline[service_account.value.service_account_token_ref].identifier}"
    }
  }

  dynamic "username_password" {
    for_each = each.value.username_password
    content {
      master_url   = username_password.value.master_url
      username     = username_password.value.username
      password_ref = username_password.value.password_ref
    }
  }

  dynamic "inherit_from_delegate" {
    for_each = each.value.inherit_from_delegate
    content {
      delegate_selectors = inherit_from_delegate.value.delegate_selectors
    }
  }
}

resource "harness_platform_connector_kubernetes_cloud_cost" "connector" {
  depends_on       = [harness_platform_connector_kubernetes.connector]
  for_each         = var.kubernetes_ccm_connector
  identifier       = "${lower(replace(each.key, "/[\\s-.]/", "_"))}_cost_access"
  name             = "${each.key}-cost-access"
  description      = each.value.description
  tags             = each.value.tags
  project_id       = each.value.project_id
  org_id           = each.value.org_id
  features_enabled = each.value.features_enabled
  connector_ref    = harness_platform_connector_kubernetes.connector[each.key].identifier
}
