variable "region" {
  description = "The region to create the resources in"
  type        = string
}

variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"
  type        = string
}

variable "availability-zone" {
  description = "Availability zone for subnets"
  type        = string
  default     = "us-east-1a"
}

variable "ami" {
  description = "Machine Image that provides the software necessary to configure and launch an EC2 instance"
  type        = string
  default     = "ami-0360c520857e3138f"
}

variable "public-subnet-for-jenkins" {
  description = "The subnet where nat gateway for Jenkins will be deployed"
  type        = string
}

data "aws_vpc" "account-vpc" {
  tags = {
    Name = "illuminati"
  }
}

