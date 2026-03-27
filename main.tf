provider "aws" {
  region = "ap-south-1"
}

terraform {
  required_version = ">= 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "devops-eks-cluster"
  cluster_version = "1.29"

  vpc_id = "vpc-0f13473ef4de3db24"

  subnet_ids = [
    "subnet-05459b04d7a3e8e10",
    "subnet-0976fa4e7134cedb9",
    "subnet-006b4eb8b72c85ef3"
  ]

  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
    Project     = "DevOps-EKS"
  }
}