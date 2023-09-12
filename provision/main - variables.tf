variable "gcp_project_id" {}
variable "gcp_region" {}
variable "gcp_machine_type" {}
variable "gcp_service_account" {}
variable "gcp_network" {}
variable "gcp_subnetwork" {}

variable "gke_cluster_name" {}
variable "gke_cluster_labels" {}
variable "gke_version_prefix" {}
variable "gke_num_nodes" {
  description = "number of gke nodes"
}

variable "tags" {}
variable "enable_harness_k8s_connector" {
  default = true
}
variable "enable_harness_ccm_connector" {
  default = true
}

