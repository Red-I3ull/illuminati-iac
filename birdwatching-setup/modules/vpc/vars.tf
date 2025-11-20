variable "vpc-id" {
  description = "The VPC ID where resources will be deployed"
  type        = string
}

variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"
  type        = string
}

variable "region" {
  description = "The region to create the resources in"
  type        = string
}

variable "availability-zone" {
  description = "Availability zone for subnets"
  type        = string
  default     = "us-east-1a"
}

variable "common_tags" {
  type = map(string)
  default = {
    "CreatedBy"  = "Terraform"
    "Project"    = "Birdwatching"
    "Repository" = "https://github.com/Maars-Team/BirdwatchingIac"
    "Module"     = "environment-setup"
  }
}

variable "internet_gateway_id" {
  description = "The Internet Gateway ID associated with the VPC"
  type        = string
}


