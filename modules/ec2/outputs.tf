# modules/ec2/outputs.tf

output "public_ec2_instance_id" {
  description = "ID of the Public EC2 instance"
  value       = aws_instance.public[*].id
}

output "public_ec2_public_ip" {
  description = "Public IP of the Public EC2 instance"
  value       = aws_instance.public[*].public_ip
}

output "private_ec2_instance_id" {
  description = "ID of the Private EC2 instance"
  value       = aws_instance.private[*].id
}
