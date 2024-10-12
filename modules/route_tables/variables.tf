variable "vpc_id" {
  type        = string
}

variable "vpc_name" {
  type        = string
}

variable "public_subnet_ids" {
  type        = list(string)
}

variable "private_subnet_ids" {
  type        = list(string)
}

variable "internet_gateway_id" {
  type        = string
}

variable "nat_gateway_id" {
  type        = string
}

variable "tags" {
  type        = map(string)
  default     = {}
}
