resource "aws_eks_addon" "aws_auth" {
  cluster_name             = var.cluster_name
  addon_name               = "vpc-cni"
  addon_version            = var.addon_version
  resolve_conflicts        = "OVERWRITE"
}

resource "aws_eks_identity_provider_config" "auth" {
  count = 0 # Placeholder for future integration with OIDC or IAM roles for users
}

