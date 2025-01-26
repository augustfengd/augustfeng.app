terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.72.1"
    }
    google = {
      source  = "hashicorp/google"
      version = "4.68.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.26.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.21.1"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.51.0"
    }
    sops = {
      source = "carlpett/sops"
      version = "1.1.1"
    }
  }
}

provider "sops" {}

provider "cloudflare" {
  api_token = data.sops_file.secrets.data["CLOUDFLARE_API_TOKEN"]
}

provider "aws" {
  region = "us-east-1" # yolo
}

provider "google" {
  project = "augustfengd"
}
