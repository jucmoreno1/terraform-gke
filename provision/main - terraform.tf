terraform {
  backend "gcs" {}
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  alias   = "gcp"
}

provider "kubernetes" {
  host                   = "https://${module.gcp.gke.endpoint}"
  token                  = module.gcp.gke.token
  cluster_ca_certificate = base64decode(module.gcp.gke.cluster_ca_certificate)
  alias                  = "gke"
}
