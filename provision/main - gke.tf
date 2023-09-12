module "gcp" {
  source              = "./modules/gcp"
  tags                = var.tags
  gcp_region          = var.gcp_region
  gcp_project_id      = var.gcp_project_id
  gcp_machine_type    = var.gcp_machine_type
  gcp_service_account = var.gcp_service_account
  gcp_network         = var.gcp_network
  gcp_subnetwork      = var.gcp_subnetwork

  gke_version_prefix = var.gke_version_prefix
  gke_num_nodes      = var.gke_num_nodes
  gke_cluster_labels = var.gke_cluster_labels
  gke_cluster_name   = var.gke_cluster_name

  providers = {
    google = google.gcp
  }
}

module "kubernetes" {
  source                       = "./modules/kubernetes"
  kubernetes_service_accounts  = local.kubernetes_service_accounts
  kubernetes_roles             = local.kubernetes_roles
  kubernetes_secrets           = local.kubernetes_secrets
  enable_harness_ccm_connector = var.enable_harness_ccm_connector

  providers = {
    kubernetes = kubernetes.gke
  }
}

module "harness" {
  depends_on               = [module.kubernetes]
  source                   = "./modules/harness"
  kubernetes_connector     = local.kubernetes_connector
  kubernetes_ccm_connector = local.kubernetes_ccm_connector
  harness_secrets          = local.harness_secrets
}
