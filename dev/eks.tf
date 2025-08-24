module "eks" {
  source                   = "git::https://github.com/windevopscloud/iac_terraform_modules.git//eks?ref=main" # tflint-ignore: terraform_module_pinned_source
  cluster_name             = var.cluster_name
  eks_version              = var.eks_version
  aws_region               = var.aws_region
  private_subnets          = module.vpc.private_subnets
  scaling_type             = var.scaling_type
  node_group               = var.node_group
  karpenter_chart_version  = var.karpenter_chart_version
  autoscaler_chart_version = var.autoscaler_chart_version
  eks_node_ami_id          = var.eks_node_ami_id
  jumpbox_ami_id           = var.jumpbox_ami_id
  vpc_id                   = module.vpc.vpc_id
}

module "eks_addons" {
  source = "git::https://github.com/windevopscloud/iac_terraform_modules.git//eks_addons?ref=main" # tflint-ignore: terraform_module_pinned_source

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