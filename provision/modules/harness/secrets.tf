resource "harness_platform_secret_text" "inline" {
  for_each                  = var.harness_secrets
  identifier                = lower(replace(each.key, "/[\\s-.]/", "_"))
  name                      = each.key
  description               = each.value.description
  tags                      = each.value.tags
  secret_manager_identifier = "account.harnessSecretManager"
  value_type                = "Inline"
  value                     = each.value.secret
}
