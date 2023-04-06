terraform {
  backend "s3" {
    profile = "turnit-staging"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.61.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
  default_tags {
    tags = {
      "Owner" : "Turnit"
      "Manager" : "Terraform"
    }
  }
  profile = "turnit-staging"
}