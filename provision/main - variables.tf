variable "project_id" {}
variable "region" {}

variable "cluster_name" {}
variable "cluster_labels" {}

variable "machine_type" {}
variable "tags" {}

variable "version_prefix" {}

variable "gke_username" {
  default     = ""
  description = "gke username"
}

variable "gke_password" {
  default     = ""
  description = "gke password"
}

variable "gke_num_nodes" {
  description = "number of gke nodes"
}

variable "store_credentials_harness" {
  description = "number of gke nodes"
  default     = true
}
