#variable for EC2 instance type

variable "vpc_id" {
    type = string
  
}

variable "instance_type" {
    type   = string
    default = "t3.micro"
}

variable "instance_ami" {
    type    = string
    default = "ami-0b6c6ebed2801a5cb"
}

variable "DB_NAME" {
    default = "db_ayub"
}
variable "DB_USER" {
    default = "admin_ayub"
}
variable "DB_PASSWORD" {
    sensitive = true 
}

variable "db_endpoint" {
    default = ""
}

variable "WEB_DIR" {
    default = "/var/www/html"
}

variable "subnet_ids" {
    type = list(string)
}


variable "Ec2_sg_id" {
    description = "Security group ID for EC2 instance"
    type = string
}

variable "public_subnet_ids" {
    type = list(string)
}