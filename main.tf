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
  subnet_ids         = ["subnet-xxxx", "subnet-yyyy"]
  vpc_id          = "vpc-xxxx"
  enable_irsa     = true

  eks_managed_node_groups = {
    eks_nodes = {
      desired_size = 2
      max_size     = 3
      min_size     = 1
      instance_types    = "t3.medium"
    }
  }
}

output "kubeconfig" {
  value = module.eks.kubeconfig
}
