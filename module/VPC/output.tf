# Outputs for the Terraform VPC

output "vpc_id" {
    description = "VPC ID, created by the VPC module"
    value       = aws_vpc.main.id
}

output "public_subnet" {
    value       = [for subnet in aws_subnet.public_subnet : subnet.id]
}

output "private_subnet" {
    value       = [for subnet in aws_subnet.private_subnet : subnet.id]
}

output "db_subnet_group_name" {
    description = "The name of the RDS DB subnet group"
    value       = aws_db_subnet_group.db_subnet_group.name
}

output "ec2_sg_id" {
    description = "value"
    value = aws_security_group.ec2_sg.id
}


output "rds_sg_id" {
    description = "The ID of the RDS security group"
    value       = aws_security_group.rds_sg.id
}