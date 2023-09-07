terraform {
  backend "gcs" {}
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.74.0"
    }
    harness = {
      source = "harness/harness"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}
