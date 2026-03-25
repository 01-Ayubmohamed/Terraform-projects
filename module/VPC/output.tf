# Outputs for the Terraform VPC

output "vpc_id" {
    description = "VPC ID, created by the VPC module"
    value       = aws_vpc.main.id
}

output "public_subnet_ids" {
    value       = [for subnet in aws_subnet.public_subnet : subnet.id]
}

output "private_subnet_ids" {
    value       = [for subnet in aws_subnet.private_subnet : subnet.id]
}

output "db_subnet_group_name" {
    description = "The name of the RDS DB subnet group"
    value       = aws_db_subnet_group.db_subnet_group.name
}

