output "op_aws_instance" {
  value = data.aws_instance.worker_instance
}

output "op_auto_scaling_group" {
  value = aws_eks_node_group.this.resources
}
