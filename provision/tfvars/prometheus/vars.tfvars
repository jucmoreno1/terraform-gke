# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

project_id   = "sales-209522"
region       = "us-central1"
cluster_name = "se-latam-prometheus-pov"

cluster_labels = {
  owner   = "cristian-ramirez"
  scope   = "internal-labs"
  purpose = "customer-pov-labs"
}

machine_type = "n1-standard-2"
tags         = ["gke-node", "sales-209522-gke"]

version_prefix = "1.27."

gke_num_nodes = 1
