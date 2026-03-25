## resource for rds 
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = var.DB_NAME
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = var.instance_class
  username             = var.DB_USER
  password             = var.DB_PASSWORD
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  db_subnet_group_name = var.db_subnet_group_name  
  vpc_security_group_ids = [aws_security_group.rds_sg.id]  # Associate the RDS security group
  
  
  
}

  resource "aws_security_group" "rds_sg" {
      name       = "rds_sg"
      description = "Security group for RDS"
      vpc_id = var.vpc_id

      ingress {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        security_groups = [var.ec2_sg_id] # Allow access from EC2 security group
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  }

