variable "launch_template_id" {
    description = "The ID of the launch template to use for the Auto Scaling group"
    type        = string
}

variable "launch_template_version" {
    description = "The version of the launch template to use for the Auto Scaling group"
    type        = string
    default     = "$Latest"
}

variable "private_subnet_ids" {
    description = "List of private subnet IDs to associate with the Auto Scaling group"
    type        = list(string)
}

variable "target_group_arns" {
    description = "List of target group ARNs to associate with the Auto Scaling group"
    type        = list(string)
}

variable "min_size" {
    description = "The minimum size of the Auto Scaling group"
    type        = number
    default     = 1
}

variable "max_size" {
    description = "The maximum size of the Auto Scaling group"
    type        = number
    default     = 3
}

variable "desired_capacity" {
    description = "The desired capacity of the Auto Scaling group"
    type        = number
    default     = 2
}

variable "tags" {
    description = "A map of tags to assign to the Auto Scaling group"
    type        = map(string)
    default     = {}
}