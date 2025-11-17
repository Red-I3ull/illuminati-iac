
data "kubernetes_namespace" "app_namespace" {
  metadata {
    name = var.app_namespace
  }
}

# resource "helm_release" "external_secrets" {
#   name       = "external-secrets"
#   repository = "https://charts.external-secrets.io"
#   chart      = "external-secrets"
#   version    = "0.19.1"

#   namespace        = var.app_namespace
#   create_namespace = false

#     depends_on = [
#     helm_release.external_secrets_crds
#     ]

#   wait = true
# }


resource "helm_release" "backend" {
  name      = "release-backend"
  namespace = var.app_namespace
  chart     = "${path.module}/../helm-charts/backend"


  depends_on = [
    data.kubernetes_namespace.app_namespace,
    var.illuminati-eks-nodes-id
  ]

  atomic          = true
  cleanup_on_fail = true
  timeout         = 600
  wait            = true
}
