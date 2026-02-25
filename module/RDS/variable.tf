# variable for RDS instance

variable "vpc_id" {
    type = string
  
}

variable "DB_NAME" {
    default = ""
}
variable "DB_USER" {
    default = ""
}
variable "DB_PASSWORD" {
    default = ""  # change later for stronger password
}
variable "instance_class" {
    type    = string
    default = "db.t3.micro"
}

variable "WEB_DIR" {
    default = "/var/www/html"
}

variable "DB_HOST" {
    default = ""
}

# variable for security group

variable "rds_sg_id" {
    description = "Security group ID for RDS"
    type = string
}

