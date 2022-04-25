terraform {
  required_version = ">= 1.1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region

  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

provider "kubernetes" {
  alias                  = "k8s-client"
  host                   = aws_eks_cluster.client.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.client.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    args        = ["eks", "get-token", "--cluster-name", "${var.eks_cluster_client_name}"]
    command     = "aws"
  }
}
