# ec2/main.tf
resource "aws_instance" "public" {
  count         = var.public_instance_count  # Sử dụng count để xác định số lượng public instances
  ami           = var.public_ami
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_id
  //key_name      = var.key_name
  vpc_security_group_ids = [var.public_ec2_sg_id]

  tags = {
    Name = "Public-Instance-${count.index + 1}"  # Đặt tên với số thứ tự
  }
}

resource "aws_instance" "private" {
  count         = var.private_instance_count  # Sử dụng count để xác định số lượng private instances
  ami           = var.private_ami
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_id
  //key_name      = var.key_name
  vpc_security_group_ids = [var.private_ec2_sg_id]

  tags = {
    Name = "Private-Instance-${count.index + 1}"  # Đặt tên với số thứ tự
  }
}
