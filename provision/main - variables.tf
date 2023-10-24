variable "gcp_project_id" {
  default = "sales-209522"
}
variable "gcp_region" {
  default = "us-central1"
}
variable "gcp_machine_type" {
  gcp_machine_type = "n1-standard-2"
}
variable "gcp_service_account" {
  default = "sales-demo-admin@sales-209522.iam.gserviceaccount.com"
}
variable "gcp_network" {
  default = "default"
}
variable "gcp_subnetwork" {
  default = "default"
}

variable "gke_cluster_name" {}
variable "gke_cluster_labels" {
  default = {
    owner   = "cristian-ramirez"
    scope   = "workshop"
    purpose = "demo"
  }
}
variable "gke_version_prefix" {
  default = "1.27."
}
variable "gke_num_nodes" {
  description = "number of gke nodes"
  default     = 2
}
variable "tags" {
  default = ["gke-node", "sales-209522-gke"]
}
variable "enable_harness_k8s_connector" {
  default = true
}
variable "enable_harness_ccm_connector" {
  default = true
}