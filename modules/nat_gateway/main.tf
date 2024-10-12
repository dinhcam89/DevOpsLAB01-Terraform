resource "aws_eip" "nat" {
  domain = "vpc"
}
resource "aws_nat_gateway" "public" {
  allocation_id = aws_eip.nat.id
  // Gán NAT vào public subnet đầu tiên
  subnet_id     = var.public_subnet_id

  tags = {
    Name = "Public NAT"
  }
}
