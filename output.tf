output "instance_id" {
    description = "The ID of the EC2 instance"
    value       = aws_instance.wordpress_instance.id
}

output "instance_public_ip" {
    description = "The public IP address of the EC2 instance"
    value       = aws_instance.wordpress_instance.public_ip
}

output "rds_endpoint" {
    description = "The endpoint of the RDS instance"
    value       = aws_db_instance.default.endpoint
}