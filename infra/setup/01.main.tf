terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.51.1"
    }
  }

  backend "s3" {
    bucket         = "cicd-testing-s3-tf-state"
    key            = "tf-state-setup"
    region         = "ap-southeast-1"
    encrypt        = true
    dynamodb_table = "cicd-testing-dynamo-tf-lock"
  }
}

provider "aws" {
  region = "ap-southeast-1"

  default_tags {
    tags = {
      Environment = terraform.workspace
      Project     = var.project
      Contact     = var.contact
      ManageBy    = "Terraform/setup"
    }
  }
}
