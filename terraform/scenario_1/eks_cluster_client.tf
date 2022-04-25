# EKS Cluster
resource "aws_eks_cluster" "client" {
  name     = var.eks_cluster_client_name
  role_arn = aws_iam_role.cluster_client_iam_role.arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids              = data.aws_subnets.public.ids
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags
  )
}

# EKS Cluster IAM Role
resource "aws_iam_role" "cluster_client_iam_role" {
  name = "${var.project}-Cluster-client-Role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "cluster_client_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster_client_iam_role.name
}
