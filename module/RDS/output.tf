# outputs for RDS module

output "DB_HOST" {
    description = "The endpoint of the RDS instance"
    value       = aws_db_instance.default.endpoint
}
