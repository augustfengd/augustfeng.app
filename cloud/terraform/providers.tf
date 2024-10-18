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
  }
}

provider "aws" {
  region = "us-east-1" # yolo
}
