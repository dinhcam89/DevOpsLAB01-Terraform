variable "vpc_name" {
  type        = string
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
}

variable "public_ami" {
  type        = string
}

variable "private_ami" {
  type        = string
}

variable "public_subnet_id" {
  type        = string
}

variable "private_subnet_id" {
  type        = string
}

variable "public_ec2_sg_id" {
  type        = string
}

variable "private_ec2_sg_id" {
  type        = string
}

variable "tags" {
  type        = map(string)
  default     = {}
}
# ec2/variables.tf
variable "public_instance_count" {
  description = "Number of EC2 instances to create in the public subnet"
  type        = number
  default     = 1  # Giá trị mặc định là 1
}

variable "private_instance_count" {
  description = "Number of EC2 instances to create in the private subnet"
  type        = number
  default     = 1  # Giá trị mặc định là 1
}

