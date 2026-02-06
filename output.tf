# Outputs for the Terraform VPC
output "vpc_id" {
    description = "The ID of the VPC"
    value       = module.VPC.vpc_id
}
output "public_subnet_ids" {
    description = "The IDs of the public subnets"
    value       = [
        module.VPC.public_subnet_ids[0],
        module.VPC.public_subnet_ids[1],
    ]
}

output "private_subnet_ids" {
    description = "The IDs of the private subnets"
    value       = [
        module.VPC.private_subnet_ids[0],
        module.VPC.private_subnet_ids[1],
    ]
}

output "db_subnet_group_name" {
    description = "The name of the RDS DB subnet group"
    value       = module.VPC.db_subnet_group_name
}

output "instance_id" {
    description = "The ID of the EC2 instance"
    value       = module.EC2.instance_id
}

output "instance_public_ip" {
    description = "The public IP address of the EC2 instance"
    value       = module.EC2.instance_public_ip
}

output "rds_endpoint" {
    description = "The endpoint of the RDS instance"
    value       = module.RDS.db_endpoint
}
