variable "vpc_id" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "security_group_ingress" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
