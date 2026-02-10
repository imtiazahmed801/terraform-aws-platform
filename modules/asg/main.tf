resource "aws_autoscaling_group" "asg" {
  name                = "aws-asg"
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = var.private_subnet_ids

  health_check_type         = "ELB"
  health_check_grace_period = 60

  launch_template {
    id      = var.launch_template_id
    version = var.launch_template_version
  }

  target_group_arns = var.target_group_arns

  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}