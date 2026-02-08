variable "instance_type" {
  description = "The type of instance to use"
  type        = string
  default     = "t3.micro"
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the instance"
  type        = list(string)
}

variable "iam_instance_profile_name" {
  description = "The IAM instance profile to associate with the instance"
  type        = string
}

variable "user_data_file" {
  description = "Path to a file containing the user data script"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the instance"
  type        = map(string)
  default     = {}
}