resource "harness_platform_secret_text" "inline" {
  for_each    = local.secrets
  identifier  = lower(replace(each.key, "/[\\s-.]/", "_"))
  name        = each.key
  description = "kubernetes secret"
  tags        = []

  secret_manager_identifier = "account.harnessSecretManager"
  value_type                = "Inline"
  value                     = each.value
}

resource "harness_platform_connector_kubernetes" "connector" {
  for_each           = local.cluster
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
      service_account_token_ref = service_account.value.service_account_token_ref
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
