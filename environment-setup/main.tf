provider "aws" {
  region = var.region
  default_tags {
    tags = {
      "CreatedBy"   = "Terraform"
      "Project"     = "illuminati"
      "Environment" = var.env
      "Repository"  = "https://github.com/Red-I3ull/illuminati-iac.git"
      "Module"      = "environment-setup"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.14.1"
    }
  }

  backend "s3" {
    bucket       = "terraform-state-illuminati-red-bull"
    key          = "environment-setup/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }

}


data "terraform_remote_state" "account-vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-state-illuminati-red-bull"
    key    = "env:/dev-01/account-setup/terraform.tfstate"
    region = "us-east-1"
  }
}
