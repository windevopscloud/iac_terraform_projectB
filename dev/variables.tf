variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
}

variable "create_public_subnets" {
  description = "Create public subnets? yes/no"
  type        = string
}

variable "public_subnets" {
  description = "CIDRs for public subnets"
  type        = list(string)
}

variable "create_private_subnets" {
  description = "Create private subnets? yes/no"
  type        = string
}

variable "private_subnets" {
  description = "CIDRs for private subnets"
  type        = list(string)
}

variable "create_isolated_subnets" {
  description = "Create isolated subnets? yes/no"
  type        = string
}

variable "isolated_subnets" {
  description = "CIDRs for isolated subnets"
  type        = list(string)
}

variable "create_igw" {
  description = "Create Internet Gateway? yes/no"
  type        = string
}

variable "create_nat_gateway" {
  description = "Create NAT Gateway? yes/no"
  type        = string
}

variable "public_nacl_ingress" {
  description = "Ingress rules for public NACL"
  type        = list(object({
    rule_number = number
    protocol    = string
    action      = string
    cidr_block  = string
    from_port   = number
    to_port     = number
  }))
}

variable "public_nacl_egress" {
  description = "Egress rules for public NACL"
  type        = list(object({
    rule_number = number
    protocol    = string
    action      = string
    cidr_block  = string
    from_port   = number
    to_port     = number
  }))
}

variable "private_nacl_ingress" {
  description = "Ingress rules for private NACL"
  type        = list(object({
    rule_number = number
    protocol    = string
    action      = string
    cidr_block  = string
    from_port   = number
    to_port     = number
  }))
}

variable "private_nacl_egress" {
  description = "Egress rules for private NACL"
  type        = list(object({
    rule_number = number
    protocol    = string
    action      = string
    cidr_block  = string
    from_port   = number
    to_port     = number
  }))
}

variable "isolated_nacl_ingress" {
  description = "Ingress rules for isolated NACL"
  type        = list(object({
    rule_number = number
    protocol    = string
    action      = string
    cidr_block  = string
    from_port   = number
    to_port     = number
  }))
}

variable "isolated_nacl_egress" {
  description = "Egress rules for isolated NACL"
  type        = list(object({
    rule_number = number
    protocol    = string
    action      = string
    cidr_block  = string
    from_port   = number
    to_port     = number
  }))
}

variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
}

variable "eks_version" {
  description = "Kubernetes version"
  type        = string
}

variable "scaling_type" {
  description = "Choose autoscaler: 'autoscaler' or 'karpenter'"
  type        = string
}

variable "node_group" {
  description = "Node group configuration (for Cluster Autoscaler)"
  type = object({
    enable         = bool
    instance_types = list(string)
    desired_size   = number
    min_size       = number
    max_size       = number
  })
}

variable "autoscaler_chart_version" {
  description = "Version of the Cluster Autoscaler Helm chart"
  type        = string
}

variable "karpenter_chart_version" {
  description = "Version of the Karpenter Helm chart"
  type        = string
}