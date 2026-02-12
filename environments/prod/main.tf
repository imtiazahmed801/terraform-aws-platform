module "iam_ec2" {
  source = "../../modules/iam-ec2"

  role_name             = "prod-ec2-role"
  instance_profile_name = "prod-ec2-instance-profile"
}

module "vpc" {
  source   = "../../modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "security_group" {
  source = "../../modules/security-group"

  vpc_id                = module.vpc.vpc_id
  alb_security_group_id = module.vpc.alb_security_group_id
}

module "launch_template" {
  source = "../../modules/launch-template"

  instance_type             = var.instance_type
  security_group_ids        = [module.security_group.ec2_security_group_id]
  iam_instance_profile_name = module.iam_ec2.instance_profile_name
  user_data_file            = "user_data.sh"

  tags = var.tags
}

module "asg" {
  source                  = "../../modules/asg"
  launch_template_id      = module.launch_template.launch_template_id
  launch_template_version = module.launch_template.launch_template_latest_version
  private_subnet_ids      = module.vpc.private_subnet_ids
  target_group_arns       = [module.vpc.app_tg_arn]

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  tags = var.tags
}