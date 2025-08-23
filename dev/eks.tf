module "custom_eks" {
    source = "git::https://github.com/windevopscloud/iac_terraform_modules.git//eks?ref=v1.0.10"
    cluster_name = var.cluster_name
    eks_version  = var.eks_version
    aws_region   = var.aws_region
    private_subnets = module.custom_vpc.private_subnets
    scaling_type    = var.scaling_type
    node_group      = var.node_group
}
