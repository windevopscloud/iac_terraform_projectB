module "custom_vpc" {
  #source = "./vpc-module"  # Path to your module
  source = "git::https://github.com/windevopscloud/iac_terraform_modules.git//vpc?ref=v1.0.12"

  vpc_cidr               = var.vpc_cidr
  azs                    = var.azs

  create_public_subnets   = var.create_public_subnets
  public_subnets          = var.public_subnets

  create_private_subnets  = var.create_private_subnets
  private_subnets         = var.private_subnets

  create_isolated_subnets = var.create_isolated_subnets
  isolated_subnets        = var.isolated_subnets

  create_igw              = var.create_igw
  create_nat_gateway      = var.create_nat_gateway

  public_nacl_ingress     = var.public_nacl_ingress
  public_nacl_egress      = var.public_nacl_egress

  private_nacl_ingress    = var.private_nacl_ingress
  private_nacl_egress     = var.private_nacl_egress

  isolated_nacl_ingress   = var.isolated_nacl_ingress
  isolated_nacl_egress    = var.isolated_nacl_egress
}