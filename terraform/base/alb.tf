# ALB + target group + ASG
resource "aws_lb" "alb" {
  name               = "alb-for-server"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.private[*].id
}

resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Security group for ALB"
  vpc_id = aws_vpc.this.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "allow_ingress_port_80" {
  count = var.is_open_port_80_for_alb == true ? 1 : 0

  description = "Security group rule allow open port 80"
  security_group_id = aws_security_group.alb_sg.id

  from_port = 80 
  to_port = 80 
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  type = "ingress"
}

resource "aws_lb_target_group_attachment" "alb_target_group_attachment" {
  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id        =  data.aws_instance.worker_instance.id
  port             = var.nodePort

  depends_on = [
    aws_eks_node_group.this
  ]
}


resource "aws_lb_target_group" "alb_target_group" {
  name     = "alb-target-group"
  port     = var.nodePort
  protocol = "HTTP"
  vpc_id   = aws_vpc.this.id
}

resource "aws_lb_listener" "server" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }

  depends_on = [
    aws_eks_node_group.this,
    aws_lb_target_group.alb_target_group
  ]
}

resource "aws_autoscaling_attachment" "asg_attachment_alb" {
  autoscaling_group_name =  aws_eks_node_group.this.resources[0].autoscaling_groups[0].name
  lb_target_group_arn    = aws_lb_target_group.alb_target_group.arn
}
