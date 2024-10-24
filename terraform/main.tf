terraform {
  required_providers {

    google = {
      source = "hashicorp/google"
      version = "5.12.0"
    }
  }

  backend "s3" {}
}

provider "google" {
  region = "us-central-1"
}

variable "gcp_credentials_path" { type= string }
variable "gcp_project" { type= string }

provider "google" {
  credentials = var.gcp_credentials_path
  project = var.gcp_project
  region = "northamerica-northeast1"
}

resource "google_compute_instance" "tf-demo-gcp-instance-1" {
  name         = "tf-demo-gcp-instance-1"
  machine_type = "e2-micro"
  zone = "northamerica-northeast1-a"

  boot_disk {
    initialize_params {
      image = "debian-11-bullseye-v20240110"
      labels = {
        my_label = "value"
      }
    }
  }

network_interface {
    network = "default"
  }
}
