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
  public_subnet_id = element(module.vpc.public_subnet_ids, 0) # Sử dụng public subnet đầu tiên
  tags             = var.tags
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

# Module Security Groups
module "security_groups" {
  source           = "./modules/security_groups"
  vpc_id           = module.vpc.vpc_id
  vpc_name         = var.vpc_name
  tags             = var.tags
}

# Module EC2
module "ec2" {
  source                   = "./modules/ec2"
  vpc_name                 = var.vpc_name
  instance_type            = var.ec2_instance_type
  public_ami               = var.public_ec2_ami
  private_ami              = var.private_ec2_ami
  public_subnet_id         = element(module.vpc.public_subnet_ids, 0)
  private_subnet_id        = element(module.vpc.private_subnet_ids, 0)
  public_ec2_sg_id         = module.security_groups.public_ec2_sg_id
  private_ec2_sg_id        = module.security_groups.private_ec2_sg_id
  public_instance_count    = 2  # Số lượng EC2 trong public subnet
  private_instance_count   = 2  # Số lượng EC2 trong private subnet
  tags                = var.tags
}
