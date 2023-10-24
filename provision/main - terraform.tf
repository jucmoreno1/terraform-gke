terraform {

  backend "http" {
    address = "https://app.harness.io/gateway/iacm/api/orgs/default/projects/Cristian_Labs_Manual_Setup/workspaces/GKE_Cristian_Workshop/terraform-backend?accountIdentifier=Io9SR1H7TtGBq9LVyJVB2w"
    username = "harness"
    lock_address = "https://app.harness.io/gateway/iacm/api/orgs/default/projects/Cristian_Labs_Manual_Setup/workspaces/GKE_Cristian_Workshop/terraform-backend/lock?accountIdentifier=Io9SR1H7TtGBq9LVyJVB2w"
    lock_method = "POST"
    unlock_address = "https://app.harness.io/gateway/iacm/api/orgs/default/projects/Cristian_Labs_Manual_Setup/workspaces/GKE_Cristian_Workshop/terraform-backend/lock?accountIdentifier=Io9SR1H7TtGBq9LVyJVB2w"
    unlock_method = "DELETE"
  }

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
