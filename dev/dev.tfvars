aws_region = "us-east-1"

vpc_cidr = "10.1.0.0/16"
azs      = ["us-east-1a", "us-east-1b"]

create_public_subnets = "yes"
public_subnets        = ["10.1.1.0/24", "10.1.2.0/24"]

create_private_subnets = "yes"
private_subnets        = ["10.1.11.0/24", "10.1.12.0/24"]

create_isolated_subnets = "no"
isolated_subnets        = []

create_igw         = "yes"
create_nat_gateway = "yes"

public_nacl_ingress = [
  { rule_number = 100, protocol = "6", action = "allow", cidr_block = "0.0.0.0/0", from_port = 80, to_port = 80 },
  { rule_number = 110, protocol = "6", action = "allow", cidr_block = "0.0.0.0/0", from_port = 443, to_port = 443 },
  { rule_number = 120, protocol = "6", action = "allow", cidr_block = "0.0.0.0/0", from_port = 22, to_port = 22 }
]

public_nacl_egress = [
  { rule_number = 100, protocol = "-1", action = "allow", cidr_block = "0.0.0.0/0", from_port = 0, to_port = 0 }
]

private_nacl_ingress = [
  { rule_number = 100, protocol = "-1", action = "allow", cidr_block = "0.0.0.0/0", from_port = 0, to_port = 0 }
]

private_nacl_egress = [
  { rule_number = 100, protocol = "-1", action = "allow", cidr_block = "0.0.0.0/0", from_port = 0, to_port = 0 }
]

isolated_nacl_ingress = [
  { rule_number = 100, protocol = "-1", action = "allow", cidr_block = "10.1.0.0/16", from_port = 0, to_port = 0 }
]

isolated_nacl_egress = [
  { rule_number = 100, protocol = "-1", action = "allow", cidr_block = "10.1.0.0/16", from_port = 0, to_port = 0 }
]

cluster_name = "projectB-EKSCluster"

eks_version = "1.30"

scaling_type = "autoscaler"

node_group = {
  enable         = true
  instance_types = ["t3.medium"]
  desired_size   = 2
  min_size       = 2
  max_size       = 4
}

autoscaler_chart_version = "9.50.1"

karpenter_chart_version = "0.16.3"