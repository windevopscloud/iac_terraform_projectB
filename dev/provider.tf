terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.9"
    }
  }
}

# -----------------------------
# AWS Provider
# -----------------------------
provider "aws" {
  region = var.aws_region
}

# -----------------------------
# EKS Cluster Auth (generates token)
# -----------------------------
data "aws_eks_cluster_auth" "eks" {
  name = module.eks.eks_cluster_name
}

# -----------------------------
# Kubernetes Provider
# -----------------------------
provider "kubernetes" {
  host                   = module.eks.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.eks_cluster_ca)
  token                  = data.aws_eks_cluster_auth.eks.token
}

# -----------------------------
# Helm Provider
# -----------------------------
provider "helm" {
  kubernetes {
    host                   = module.eks.eks_cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.eks_cluster_ca)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}