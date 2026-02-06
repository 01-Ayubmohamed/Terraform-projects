# outputs for RDS module

output "db_endpoint" {
    description = "The endpoint of the RDS instance"
    value       = aws_db_instance.default.endpoint
}
