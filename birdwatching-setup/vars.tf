variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"
  type        = string
}

variable "ami_name" {
  description = "The port the server will use for HTTP requests"
  type        = string
}

variable "public-subnets-for-lb" {
  description = "CIDR block for lb-subnet"
  type        = string
}

variable "private-subnets-for-db" {
  description = "CIDR block for lb-subnet"
  type        = string
}

variable "private-subnets-for-web" {
  description = "CIDR block for lb-subnet"
  type        = string
}

variable "region" {
  description = "The region to create the resources in"
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

variable "dns-name" {
  description = "domain name for our app"
  type        = string
}

variable "ami" {
  description = "Machine Image that provides the software necessary to configure and launch an EC2 instance"
  type        = string
  default     = "ami-00e0783671577b712"
}

variable "private-subnets-for-consul" {
  description = "CIDR block for consul-subnet"
  type        = string

}

variable "internet_gateway_id" {
  description = "The Internet Gateway ID associated with the VPC"
  type        = string
}

variable "private-route-table-id" {
  description = "Existing private route table ID"
  type        = string
}

variable "public-route-table-id" {
  description = "Existing public route table ID"
  type        = string
}

#DATA CODE BLOCK
data "aws_route_table" "private-route-table" {
  route_table_id = var.private-route-table-id
}

data "aws_route_table" "public-route-table" {
  route_table_id = var.public-route-table-id
}

data "aws_iam_instance_profile" "photosaver_profile" {
  name = "photosaver-profile"
}

data "aws_eip" "lb-eip" {
  tags = {
    Name = "lb-eip-1"
  }
}

data "aws_key_pair" "jenkins-key-pair" {
  key_name = "jenkins-public"
}

data "aws_subnet" "public-subnet-for-jenkins" {
  tags ={
    Name   = "public-us-east-1a-jenkins"
  }
}

data "aws_vpc" "account-vpc" {
  tags = {
    Name = "illuminati"
  }
}








