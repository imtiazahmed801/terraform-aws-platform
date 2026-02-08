output "launch_template_id" {
  description = "ID of the launch template"
  value       = aws_launch_template.lt_instance.id
}

output "launch_template_latest_version" {
  description = "Latest version number of the launch template"
  value       = aws_launch_template.lt_instance.latest_version
}