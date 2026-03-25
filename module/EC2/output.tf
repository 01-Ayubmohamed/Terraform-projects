#outputs for EC2 module


output "ec2_instance_id" {
    description = "The ID of the EC2 instance"
    value       = aws_instance.wordpress_instance.id
}

output "wordpress_public_ip" {
    description = "The public IP address of the EC2 instance"
    value       = aws_instance.wordpress_instance.public_ip
}

output "ec2_sg_id" {
    description = "The security group ID for the EC2 instance"
    value       = aws_security_group.ec2_sg.id
}

