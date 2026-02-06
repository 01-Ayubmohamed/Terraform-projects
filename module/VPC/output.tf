# Outputs for the Terraform VPC

output "vpc_id" {
    description = "VPC ID, created by the VPC module"
    value       = aws_vpc.main.id
}

output "public_subnet_ids" {
    description = "The IDs of the public subnets"
    value       = [
        aws_subnet.public_subnet1.id,
        aws_subnet.public_subnet2.id,
    ]
}

output "private_subnet_ids" {
    description = "The IDs of the private subnets"
    value       = [
        aws_subnet.private_subnet1.id,
        aws_subnet.private_subnet2.id,
    ]
}

output "db_subnet_group_name" {
    description = "The name of the RDS DB subnet group"
    value       = aws_db_subnet_group.db_subnet_group.name
}

output "EC2_sg_id" {
    description = "The ID of the EC2 security group"
    value       = aws_security_group.ec2_sg.id
}


output "rds_sg_id" {
    description = "The ID of the RDS security group"
    value       = aws_security_group.rds_sg.id
}