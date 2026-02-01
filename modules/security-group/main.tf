resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"
  description = "allows inbound traffic from ALB"
  vpc_id      = var.vpc_id

  ingress {
    description     = "allow http from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id]
  }

  egress {
    description = "allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "ec2-security-group"
    Managedby = "Terraform"
  }
}