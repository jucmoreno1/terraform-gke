# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "region" {
  value       = var.gcp_region
  description = "GCloud Region"
}

output "project_id" {
  value       = var.gcp_project_id
  description = "GCloud Project ID"
}

output "kubernetes_cluster_name" {
  value       = module.gcp.gke.name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = module.gcp.gke.endpoint
  description = "GKE Cluster Host"
}
