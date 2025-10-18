provider "aws" {
  region = var.region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.14.1"
    }
  }

}

data "terraform_remote_state" "account-vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-state-birdwatching"
    key    = "env:/dev-01/account-setup/terraform.tfstate"
    region = "us-east-1"
  }
}
