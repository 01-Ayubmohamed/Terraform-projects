resource "aws_alb" "wp_alb" {
  name               = "wp-alb"
  internal           = false
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.subnet_ids
  load_balancer_type = "application" 
  tags = {
    Name = "wp-alb"
  }
  
}

resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_alb.wp_alb.arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.wp_cert.arn

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.wp_target_group.arn
  }
}

resource "aws_lb_listener" "wp_listener" {
  load_balancer_arn = aws_alb.wp_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port = 443 
      protocol = "HTTPS"
      status_code = "HTTP_301"
    }
  }

}

resource "aws_lb_target_group" "wp_target_group" {
  vpc_id = var.vpc_id
  name     = "wp-target-group"
  port     = 80
  protocol = "HTTP"
  health_check {
      path                = "/"
      protocol            = "HTTP"
      interval            = 30
      timeout             = 5
      healthy_threshold   = 2
      unhealthy_threshold = 2
    }
}

resource "aws_lb_target_group_attachment" "lb_tg_attachment" {
  target_group_arn = aws_lb_target_group.wp_target_group.arn
  target_id        = var.ec2_instance_id
  port             = 80
  
}


resource "aws_acm_certificate" "wp_cert" {
  domain_name       = "ayubcoderco.com"
  validation_method = "DNS"

  tags = {
    Name = "wp-cert"
  }

  lifecycle {
    create_before_destroy = true
  }
}



resource "aws_security_group" "alb_sg" {
  name        = "alb_security_group"
  description = "Security group for ALB with dynamic rules"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.alb_sg
    iterator = port 
    content {
      from_port   = port.value.port
      to_port     = port.value.port
      protocol    = port.value.protocol
      cidr_blocks = port.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  
}
}