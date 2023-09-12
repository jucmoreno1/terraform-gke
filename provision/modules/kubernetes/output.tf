output "service_account_token" {
  value = { for k, v in kubernetes_secret_v1.sa : k => v }
}
