data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}

data "aws_instance" "worker_instance" {
  instance_tags = {
    "eks:cluster-name" =  var.eks_cluster_name
    "eks:nodegroup-name" = var.node_group_name
  }

  filter {
    name = "vpc-id"
    values = [aws_vpc.this.id]
  }

  filter {
    name = "instance-state-name"
    values = ["pending", "running"]
  }

  depends_on = [
    aws_eks_node_group.this
  ]
}
