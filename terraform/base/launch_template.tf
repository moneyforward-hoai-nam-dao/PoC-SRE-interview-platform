resource "aws_launch_template" "launch_temple_v2" {
  name                   =  var.launch_template_name
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.additional_security_launch_template.id, aws_eks_cluster.this.vpc_config[0].cluster_security_group_id]
}

resource "aws_security_group" "additional_security_launch_template" {
  name   = "additional_security_group_for_launch_template"
  vpc_id = aws_vpc.this.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.nodePort
    to_port     = var.nodePort
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
