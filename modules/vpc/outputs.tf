output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value = [
    aws_subnet.private_subnet_a.id,
    aws_subnet.private_subnet_b.id,
  ]
}

output "alb_security_group_id" {
  description = "The ID of the ALB security group"
  value       = aws_security_group.alb_sg.id
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpcblock.id
}

output "app_tg_arn" {
  description = "ARN of application of target group"
  value       = aws_lb_target_group.app_tg.arn
}