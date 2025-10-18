variable "region" {
  description = "The region to create the resources in"
  type        = string
}

variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"
  type        = string
}

variable "username" {
  description = "List of users that must be created and added to the Administrators group"
  type        = list(string)
}

variable "ami" {
  description = "Machine Image that provides the software necessary to configure and launch an EC2 instance"
  type        = string
}

variable "private-subnets-for-jenkins" {
  description = "The subnet where Jenkins will be deployed"
  type        = string
}

variable "instance-type" {
  description = "default instance type for our project"
  type        = string
}

variable "availability-zone" {
  description = "Availability zone for subnets"
  type        = string
}
