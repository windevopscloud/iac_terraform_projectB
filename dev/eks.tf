module "eks" {
  source                   = "git::https://github.com/windevopscloud/iac_terraform_modules.git//eks?ref=v1.0.21"
  cluster_name             = var.cluster_name
  eks_version              = var.eks_version
  aws_region               = var.aws_region
  private_subnets          = module.vpc.private_subnets
  scaling_type             = var.scaling_type
  node_group               = var.node_group
  karpenter_chart_version  = var.karpenter_chart_version
  autoscaler_chart_version = var.autoscaler_chart_version
}

module "eks_addons" {
  source = "git::https://github.com/windevopscloud/iac_terraform_modules.git//eks_addons?ref=v1.0.21"

  cluster_name             = module.eks.eks_cluster_name
  scaling_type             = var.scaling_type
  karpenter_chart_version  = var.karpenter_chart_version
  autoscaler_chart_version = var.autoscaler_chart_version
  karpenter_oidc_arn       = module.eks.karpenter_oidc_arn
  private_subnets          = module.vpc.private_subnets
  aws_region               = var.aws_region
  cluster_ca               = module.eks.eks_cluster_ca
  cluster_endpoint         = module.eks.cluster_endpoint
}