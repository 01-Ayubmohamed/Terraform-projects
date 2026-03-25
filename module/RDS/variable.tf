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
variable "db_subnet_group_name" {
    type = string
}

# variable for security group


variable "ec2_sg_id" {
    description = "Security group ID for EC2"
    type = string
}
