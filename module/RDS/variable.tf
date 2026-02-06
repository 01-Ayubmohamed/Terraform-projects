# variable for RDS instance

variable "vpc_id" {
    type = string
  
}

variable "DB_NAME" {
    default = "db_ayub"
}
variable "DB_USER" {
    default = "admin_ayub"
}
variable "DB_PASSWORD" {
    default = "123" # change later for stronger password
}
variable "instance_class" {
    type    = string
    default = "db.t3.micro"
}

variable "DB_HOST" {
    default = ""
}

variable "WEB_DIR" {
    default = "/var/www/html"
}


# variable for security group

variable "rds_sg_id" {
    description = "Security group ID for RDS"
    type = string
}
