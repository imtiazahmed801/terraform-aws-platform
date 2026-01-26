resource "aws_vpc" "vpcblock" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name      = "core-vpc"
    ManagedBy = "Terraform"
  }
}