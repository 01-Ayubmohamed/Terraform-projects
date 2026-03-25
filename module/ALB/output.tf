output alb_sg_id {
  description = "The ID of the ALB security group"
  value       = aws_security_group.alb_sg.id
}

output wp_target_group_arn {
  description = "The ARN of the target group for the ALB"
  value       = aws_lb_target_group.wp_target_group.arn
}

output "alb_dns_name" {
  description = "The domain name of the ALB"
  value       = aws_alb.wp_alb.dns_name
}
