resource "aws_vpc" "vpcblock" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name      = "core-vpc"
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id = aws_vpc.vpcblock.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id = aws_vpc.vpcblock.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true  
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpcblock.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpcblock.id
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  }

  resource "aws_route_table_association" "public_subnet_a_assoc" {
    subnet_id      = aws_subnet.public_subnet_a.id
    route_table_id = aws_route_table.public_rt.id
  }

  resource "aws_route_table_association" "public_subnet_b_assoc" {
    subnet_id      = aws_subnet.public_subnet_b.id
    route_table_id = aws_route_table.public_rt.id
  }

resource "aws_subnet" "private_subnet_a" {
  vpc_id = aws_vpc.vpcblock.id
  cidr_block = "10.0.56.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id = aws_vpc.vpcblock.id
  cidr_block = "10.0.57.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.public_subnet_a.id
  tags = {
    Name = "nat_gw"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpcblock.id
  tags = {
    Name = "private-rt"
  }
}

resource "aws_route" "private_default_route" {
  route_table_id = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gw.id
}

resource "aws_route_table_association" "private_subnet_a_assoc" {
  subnet_id = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_subnet_b_assoc" {
  subnet_id = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.private_rt.id
}