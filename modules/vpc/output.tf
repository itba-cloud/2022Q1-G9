output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "VPC CIDR Block"
  value       = aws_vpc.main.cidr_block
}

output "public_subnets_ids" {
  description = "VPC Public Subnets ID"
  value = [
    for k, v in aws_subnet.public : v.id
  ]
}

output "private_subnets_ids" {
  description = "VPC Private Subnets ID"
  value = [
    for k, v in aws_subnet.private : v.id
  ]
}