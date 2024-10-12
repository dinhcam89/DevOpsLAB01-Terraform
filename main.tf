provider "aws" {
  region = var.region
}

# Module VPC
module "vpc" {
  source             = "./modules/vpc"
  region             = var.region
  vpc_cidr           = var.vpc_cidr
  vpc_name           = var.vpc_name
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
  tags               = var.tags
}

# Module NAT Gateway
module "nat_gateway" {
  source           = "./modules/nat_gateway"
  vpc_id           = module.vpc.vpc_id
  vpc_name         = var.vpc_name
  public_subnet_id = module.vpc.public_subnet_ids[0] 
}

# Module Route Tables
module "route_tables" {
  source              = "./modules/route_tables"
  vpc_id              = module.vpc.vpc_id
  vpc_name            = var.vpc_name
  public_subnet_ids   = module.vpc.public_subnet_ids
  private_subnet_ids  = module.vpc.private_subnet_ids
  internet_gateway_id = module.vpc.internet_gateway_id
  nat_gateway_id      = module.nat_gateway.nat_gateway_id
  tags                = var.tags
}

# Module Security Groups for public EC2s
module "public_security_groups" {
  source = "./modules/security_groups"

  vpc_id  = module.vpc.vpc_id
  name    = "${var.vpc_name}-sg"
  description = "Security Group for ${var.vpc_name}"

  ingress_rules = [
    {
      description      = "Allow SSH from specific IP"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = [var.my_ip_cidr]
    },
    {
      description      = "Allow HTTP from anywhere"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    },
    {
      description      = "Allow HTTPS from anywhere"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  ]

  egress_rules = [
    {
      description      = "Allow all outbound traffic"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  ]

  tags = var.tags
}

# Module Security Groups for private EC2s
module "private_security_groups" {
  source = "./modules/security_groups"

  vpc_id      = module.vpc.vpc_id
  name        = "${var.vpc_name}-private-sg"
  description = "Security Group for Private EC2 instances"

  ingress_rules = [
    {
      description     = "Allow SSH from Public SG"
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      security_groups = [module.public_security_groups.security_group_id]
    },
    {
      description     = "Allow internal traffic from within the SG"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      self            = true
    }
  ]

  egress_rules = [
    {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = var.tags
}
# Module EC2
module "ec2" {
  source                   = "./modules/ec2"
  vpc_name                 = var.vpc_name
  instance_type            = var.ec2_instance_type
  public_ami               = var.public_ec2_ami
  private_ami              = var.private_ec2_ami
  public_subnet_id         = module.vpc.public_subnet_ids[0]
  private_subnet_id        = module.vpc.private_subnet_ids[0]
  public_ec2_sg_id         = module.public_security_groups.security_group_id
  private_ec2_sg_id        = module.private_security_groups.security_group_id
  public_instance_count    = 1  # Số lượng EC2 trong public subnet
  private_instance_count   = 1  # Số lượng EC2 trong private subnet
  tags                     = var.tags
}
