module "helm_releases" {
  source = "./modules/frontend-release"

  env = var.env

  app_namespace = var.app_namespace

  frontend_image_repository = var.frontend_image_repository
  frontend_image_tag        = var.frontend_image_tag
  frontend_replicas         = var.frontend_replicas
  illuminati-eks-nodes-id   = var.illuminati-eks-nodes-id

}