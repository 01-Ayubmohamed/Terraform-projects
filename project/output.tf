# Outputs for the Terraform VPC
output "vpc_id" {
    description = "The ID of the VPC"
    value       = module.VPC.vpc_id
}

output "db_subnet_group_name" {
    description = "The name of the RDS DB subnet group"
    value       = module.VPC.db_subnet_group_name
}

output "ec2_instance_id" {
    description = "The ID of the EC2 instance"
    value       = module.EC2.ec2_instance_id
}

output "wordpress_public_ip" {
    description = "The public IP address of the EC2 instance"
    value       = module.EC2.wordpress_public_ip
}

output "db_endpoint" {
    description = "The endpoint of the RDS instance"
    value       = module.RDS.db_endpoint
}

output "alb_dns_name" {
  description = "The domain name of the ALB"
  value       = module.ALB.alb_dns_name
}
