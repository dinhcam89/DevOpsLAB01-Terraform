output "public_ec2_sg_id" {
  description = "Security Group ID for Public EC2 instances"
  value       = aws_security_group.allow_ssh.id
}

output "private_ec2_sg_id" {
  description = "Security Group ID for Private EC2 instances"
  value       = aws_security_group.allow_http.id
}