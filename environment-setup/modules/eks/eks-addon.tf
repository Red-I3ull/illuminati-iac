resource "aws_eks_addon" "pod_identity" {
  cluster_name  = aws_eks_cluster.illuminati-eks.name
  addon_name    = "eks-pod-identity-agent"
  addon_version = "v1.2.0-eksbuild.1"
  depends_on    = [aws_eks_cluster.illuminati-eks]
}


resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name                = aws_eks_cluster.illuminati-eks.name
  addon_name                  = "aws-ebs-csi-driver"
  addon_version               = "v1.30.0-eksbuild.1"
  resolve_conflicts_on_create = "OVERWRITE"
  depends_on                  = [aws_eks_addon.pod_identity]
}