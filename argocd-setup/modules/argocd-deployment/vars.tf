variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"
  type        = string
}

variable "region" {
  description = "The region to create the resources in"
  type        = string
}

variable "cluster-name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "argocd-version" {
  description = "Version of ArgoCD to deploy"
  type        = string
}
