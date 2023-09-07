# VPC
/* resource "google_compute_network" "vpc" {
  name                    = "${var.project_id}-vpc"
  auto_create_subnetworks = "false"
} */

# Subnet
/* resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project_id}-selatam-gke-subnet"
  region        = var.region
  network       = "default"
  ip_cidr_range = "10.10.0.0/24"
} */
