module "iam_ec2" {
  source = "../../modules/iam-ec2"

  role_name             = "dev-ec2-role"
  instance_profile_name = "dev-ec2-instance-profile"
}

module "ec2" {
  source = "../../modules/ec2"

  instance_type        = "t3.micro"
  private_subnet_ids   = module.vpc.private_subnet_ids
  security_group_ids   = [module.security_group.ec2_security_group_id]
  iam_instance_profile = module.iam_ec2.instance_profile_name

  tags = {
    Environment = "dev"
    Project     = "flagship-aws-platform"
    Owner       = "imtiaz"
  }
}

module "security_group" {
  source = "../../modules/security-group"

  vpc_id                = module.vpc.vpc_id
  alb_security_group_id = module.vpc.alb_security_group_id
}

resource "aws_lb_target_group_attachment" "ec2_attachment" {
  target_group_arn = module.vpc.app_tg_arn
  target_id        = module.ec2.instance_id
  port             = 80
}