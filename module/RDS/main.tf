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
  vpc_security_group_ids = [var.rds_sg_id]
  
}

