#variable for EC2 instance type

variable "vpc_id" {
    type = string
}
  
# variable for public and private subnets

variable "public_subnets" {
    type = list(object({
        cidr_block = string
        az         = string
    }))
}

variable "private_subnets" {
    type = list(object({
        cidr_block = string
        az         = string
    }))
}

variable "az" {
    type = list(string)
}

variable "ec2_sg_id" {
    description = "Security group ID for EC2 instance"
    type = string
}



# variable for EC2 
variable "instance_type" {
    type   = string
    default = "t3.micro"
}

variable "instance_ami" {
    type    = string
    default = "ami-0b6c6ebed2801a5cb"
}



# variables for rds 
variable "DB_NAME" {
    default = ""
}
variable "DB_USER" {
    default = ""
}
variable "DB_PASSWORD" {
    sensitive = true 
}


variable "DB_HOST" {
    default = ""
}

variable "WEB_DIR" {
    default = "/var/www/html"
}
