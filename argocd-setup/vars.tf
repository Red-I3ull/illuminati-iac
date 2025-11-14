variable "region" {
  description = "The region to create the resources in"
  type        = string
}

variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"
  type        = string
}

variable "cluster-name" {
  description = "name of transferred EKS cluster"
}

data "aws_eks_cluster" "illuminati_eks" {
  name = var.cluster-name
}

data "aws_subnets" "private_subnets" {
  filter {
    name   = "tag:Name"
    values = ["private-us-east-1a-${var.env}", "private-us-east-1b-${var.env}"]
  }
}

data "aws_eks_cluster_auth" "illuminati_eks" {
  name = var.cluster-name
}

variable "argocd-chart-version" {
  description = "version of argoCD helm chart"
  type        = string
}

variable "app-namespace" {
  description = "The Kubernetes namespace to deploy the app into"
  type        = string
}
