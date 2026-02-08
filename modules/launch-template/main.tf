data "aws_ami" "ami_latest" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_launch_template" "lt_instance" {
    image_id = data.aws_ami.ami_latest.id
    instance_type = var.instance_type
    vpc_security_group_ids = var.security_group_ids

    iam_instance_profile {
        name = var.iam_instance_profile_name
    }

    user_data = base64encode(file("${path.module}/${var.user_data_file}"))
    
    tag_specifications {
      resource_type = "instance"
      tags = var.tags
    }
}