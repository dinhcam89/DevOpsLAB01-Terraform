resource "aws_security_group" "public_ec2_sg" {
  name        = "public-ec2-sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.security_group_ingress
    content {
      description = "description ${ingress.key}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  tags = merge(
    {
      Name = "${var.vpc_name}-allow-ssh"
    },
    var.tags
  )
}

resource "aws_security_group" "allow_http" {
  name        = "${var.vpc_name}-allow-http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name = "${var.vpc_name}-allow-http"
    },
    var.tags
  )
}
