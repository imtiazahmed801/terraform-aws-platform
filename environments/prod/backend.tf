terraform {
  backend "s3" {
    bucket         = "tf-state-aws-platform-56"
    key            = "environments/prod/terraform.tfstate"
    dynamodb_table = "tf-state-locks"
    region         = "us-east-1"
  }
}
