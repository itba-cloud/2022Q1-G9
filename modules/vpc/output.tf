output "id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "cidr" {
  description = "VPC CIDR Block"
  value       = aws_vpc.main.cidr_block
}

output "private_subnets_ids" {
  description = "VPC Private Subnets ID"
  value = [
    for k, v in aws_subnet.private : v.id
  ]
}