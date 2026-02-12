instance_type = "t2.micro"

min_size         = 0
max_size         = 1
desired_capacity = 1

vpc_cidr = "10.0.0.0/16"

tags = {
  Environment = "prod"
  Project     = "flagship-aws-platform"
  Owner       = "imtiaz"
}