# project/variables.tf

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "my-custom-vpc"
}

variable "public_subnets" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "tags" {
  description = "Additional tags to assign to resources"
  type        = map(string)
  default     = {
    Environment = "dev"
    Project     = "Terraform Infrastructure"
  }
}

variable "my_ip_cidr" {
  description = "Your IP address with /32 CIDR for SSH access"
  type        = string
  default     = "0.0.0.0/0" # Thay đổi thành IP cụ thể, ví dụ: "123.45.67.89/32"
}

variable "ec2_instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "public_ec2_ami" {
  description = "AMI ID for Public EC2 instances"
  type        = string
  default     = "ami-0c02fb55956c7d316" # Thay đổi theo khu vực và yêu cầu
}

variable "private_ec2_ami" {
  description = "AMI ID for Private EC2 instances"
  type        = string
  default     = "ami-0c02fb55956c7d316" # Thay đổi theo khu vực và yêu cầu
}

variable "create_public_ec2" {
  description = "Flag to create Public EC2 instance"
  type        = bool
  default     = true
}

variable "create_private_ec2" {
  description = "Flag to create Private EC2 instance"
  type        = bool
  default     = true
}
