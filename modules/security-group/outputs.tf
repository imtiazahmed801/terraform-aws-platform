output "ec2_security_group_id" {
  description = "The ID of the security group for EC2 instances"
  value       = aws_security_group.ec2_sg.id
}