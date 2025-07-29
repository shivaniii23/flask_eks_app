provider "aws" {
  region = "us-east-1"
}

resource "aws_ecr_repository" "flask_repo" {
  name = "flask-eks"
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"
  name    = "flask-eks-cluster"
  kubernetes_version = "1.27"
  subnet_ids         = ["subnet-095034fe1ab67bcfd", "subnet-031397bfac02b26f3"]
  vpc_id          = "vpc-0b1beb801f37a0470"
  enable_irsa     = true

  eks_managed_node_groups = {
    eks_nodes = {
      desired_size = 2
      max_size     = 3
      min_size     = 1
      instance_types    = ["t3.medium"]
    }
  }
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
