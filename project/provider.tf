terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.27.0"
    }
  }

  backend "s3" {
    bucket = "terraform-state-ayub"
    key = "wordpress/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true  

}
}

provider "aws" {
  region = "us-east-1"
  # Configuration options
}

