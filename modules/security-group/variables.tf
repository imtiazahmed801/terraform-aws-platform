variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created"
  type        = string
}

variable "alb_security_group_id" {
  description = "The ID of the ALB security group to allow inbound traffic from"
  type        = string
}
