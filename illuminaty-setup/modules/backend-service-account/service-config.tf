

data "aws_eks_cluster" "cluster" {
  name = var.eks_cluster_name
}


data "aws_iam_policy" "secrets_manager_read" {
  name = "secrets-manager-read"
}

data "tls_certificate" "eks" {
  url = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks" {
  url = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer

  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]

  tags = {
    Name = "${var.eks_cluster_name}-oidc-provider"
  }
}

resource "aws_iam_role" "external_secrets_role" {
  name = "external-secrets-role-backend"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.eks.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub" = "system:serviceaccount:${var.app_namespace}:backend-service-account"
            "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:aud" = "sts.amazonaws.com"
          }
        }
      }
    ]
  })

  tags = {
    Name        = "external-secrets-role"
    Environment = var.env
    ManagedBy   = "Terraform"
  }
}


resource "aws_iam_role_policy_attachment" "external_secrets_policy" {
  role       = aws_iam_role.external_secrets_role.name
  policy_arn = data.aws_iam_policy.secrets_manager_read.arn
}


resource "kubernetes_service_account" "backend_sa" {
  metadata {
    name      = "backend-service-account"
    namespace = var.app_namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.external_secrets_role.arn
    }
  }
}

