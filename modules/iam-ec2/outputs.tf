output "instance_profile_name" {
  description = "IAM instance profile name for EC2"
  value       = aws_iam_instance_profile.ec2_app_profile.name
}

output "role_name" {
  description = "IAM role name assumed by EC2"
  value       = aws_iam_role.ec2_role.name
}