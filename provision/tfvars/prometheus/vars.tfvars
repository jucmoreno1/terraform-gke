gcp_project_id      = "sales-209522"
gcp_region          = "us-central1"
gcp_machine_type    = "n2-standard-2"
gcp_service_account = "sales-demo-admin@sales-209522.iam.gserviceaccount.com"
gcp_network         = "default"
gcp_subnetwork      = "default"

gke_cluster_name   = "se-latam-prometheus-pov"
gke_version_prefix = "1.27."
gke_num_nodes      = 1
gke_cluster_labels = {
  owner   = "cristian-ramirez"
  scope   = "internal-labs"
  purpose = "customer-pov-labs"
}

tags = ["gke-node", "sales-209522-gke"]

enable_harness_k8s_connector = true
enable_harness_ccm_connector = true
