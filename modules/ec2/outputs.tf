output "private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.ec2_instance.private_ip
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.ec2_instance.id
}
