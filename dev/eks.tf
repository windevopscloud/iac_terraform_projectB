module "custom_eks" {
    source = "git::https://github.com/windevopscloud/iac_terraform_modules.git//eks?ref=v1.0.4"
    cluster_name = var.cluster_name
    eks_version  = var.eks_version
    region       = var.aws_region
    private_subnets = module.vpc.private_subnets
    scaling_type = var.scaling_type
    node_group = var.node_group
}
