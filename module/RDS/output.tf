# outputs for RDS module

output "db_endpoint" {
    description = "The endpoint of the RDS instance"
    value       = aws_db_instance.default.endpoint
}


output "rds_sg_id" {
    description = "The ID of the RDS security group"
    value       = aws_security_group.rds_sg.id
}