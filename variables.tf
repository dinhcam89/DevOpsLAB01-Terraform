variable "region" {
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  type        = string
  default     = "my-custom-vpc"
}

variable "public_subnets" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "tags" {
  type        = map(string)
  default     = {
    Environment = "dev"
    Project     = "Terraform Infrastructure"
  }
}

variable "public_ssh_cidr" {
  type        = string
  default     = "0.0.0.0/0"
}

variable "ec2_instance_type" {
  type        = string
  default     = "t2.micro"
}

variable "public_ec2_ami" {
  type        = string
  default     = "ami-0c02fb55956c7d316" # ami của EC2 t2.micro
}

variable "private_ec2_ami" {
  type        = string
  default     = "ami-0c02fb55956c7d316" # ami của EC2 t2.micro
}

variable "create_public_ec2" {
  type        = bool
  default     = true
}

variable "create_private_ec2" {
  type        = bool
  default     = true
}
