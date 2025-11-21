
resource "kubernetes_namespace" "app_namespace" {
  metadata {
    name = var.app_namespace
    labels = {
      name        = var.app_namespace
      environment = var.env
    }
  }
}

# resource "helm_release" "frontend" {
#   name      = "release-frontend"
#   namespace = kubernetes_namespace.app_namespace.metadata[0].name
#   chart     = "${path.module}/../helm-charts/frontend"
#
#   values = [
#     templatefile("${path.module}/../helm-charts/frontend/values.yaml.tpl", {
#       frontend_image_repository = var.frontend_image_repository
#       frontend_image_tag        = var.frontend_image_tag
#       frontend_replicas         = var.frontend_replicas
#     })
#   ]
#
#   depends_on = [
#     kubernetes_namespace.app_namespace,
#     var.illuminati-eks-nodes-id
#   ]
#
#   atomic          = true
#   cleanup_on_fail = true
#   timeout         = 600
#   wait            = true
# }
