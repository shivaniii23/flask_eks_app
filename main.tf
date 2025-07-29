provider "aws" {
  region = "us-east-1"
}

resource "aws_ecr_repository" "flask_repo" {
  name = "flask-eks"
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "flask-eks-cluster"
  cluster_version = "1.27"
  subnets         = ["subnet-xxxx", "subnet-yyyy"]
  vpc_id          = "vpc-xxxx"
  enable_irsa     = true

  node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_type    = "t3.medium"
    }
  }
}

output "kubeconfig" {
  value = module.eks.kubeconfig
}
