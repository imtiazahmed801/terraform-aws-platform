terraform {
  backend "s3" {
    bucket         = "tf-state-aws-platform-56"
    key            = "environments/dev/terraform.tfstate"
    dynamodb_table = "tf-state-locks"
    region         = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

module "vpc" {
  source   = "../../modules/vpc"
  vpc_cidr = "10.0.0.0/16"
}