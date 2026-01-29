terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.27.0"
    }
  }

  backend "s3" {
    bucket = "terraform-state-ayub"
    key = "terraform-projects-1/terraform.tfstate"
    region = "us-east-1"
}
}


provider "aws" {
  region = "us-east-1"
  # Configuration options
}

