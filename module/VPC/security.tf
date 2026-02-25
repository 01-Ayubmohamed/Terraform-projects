resource "aws_security_group" "ec2_sg" {
  name        = "ec2_security_group"
  description = "Security group with dynamic rules"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.ec2_sg_id
    iterator = port 
    content {
      from_port   = port.value.port
      to_port     = port.value.port
      protocol    = port.value.protocol
      cidr_blocks = port.value.cidr_blocks
      description = port.value.description
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
    

    resource "aws_security_group" "rds_sg" {
      name       = "rds_sg"
      description = "Security group for RDS with dynamic rules"

      ingress {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        security_groups = [aws_security_group.ec2_sg.id]
    }
    }