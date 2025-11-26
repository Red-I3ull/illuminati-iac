resource "helm_release" "loki" {
  name             = "loki"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "loki"
  namespace        = "monitoring"
  create_namespace = true

  values = [
    file("${path.module}/loki-values.yaml")
  ]


}


resource "helm_release" "alloy" {
  name       = "alloy"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "alloy"
  namespace  = "monitoring"

  set {
    name  = "controller.type"
    value = "daemonset"
  }

  values = [
    file("${path.module}/alloy-values.yaml")
  ]

  depends_on = [helm_release.loki]
}