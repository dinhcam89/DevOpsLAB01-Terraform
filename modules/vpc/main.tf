provider "aws" {
  region = var.region
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet" {
  count                     = length(var.public_subnets)
  vpc_id                    = aws_vpc.vpc.id
  cidr_block                = var.public_subnets[count.index]
  availability_zone         = var.availability_zones[count.index % length(var.availability_zones)]
  map_public_ip_on_launch   = true
  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  count                     = length(var.public_subnets)
  vpc_id                    = aws_vpc.vpc.id
  cidr_block                = var.private_subnets[count.index]
  availability_zone         = var.availability_zones[count.index % length(var.availability_zones)]
  map_public_ip_on_launch   = false
  tags = {
    Name = "Private Subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Internet Gateway"
  }
}
// Default Security Group for VPC
resource "aws_security_group" "default" {
  name        = "${var.vpc_name}-default-sg"
  description = "Default security group for ${var.vpc_name}"
  vpc_id      = aws_vpc.vpc.id

  # Ingress Rule
  ingress {
    description      = "Allow all inbound traffic from within the VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.vpc_cidr]
    ipv6_cidr_blocks = []
  }

  # Egress Rule
  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
  }
}
