#variable for vpc 

variable "azs" {
    description = "List of availability zones"
    default    = ["us-east-1a", "us-east-1b"]
}

variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    default     = "10.0.0.0/16"
}

variable "db_subnet_group_name" {
    default = "rds-subnet-group"
}


# variable for subnet 

variable "subnet_cidrs" {
    description = "List of subnet CIDR blocks"
    default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
}


# variable for EC2 instance type
variable "instance_type" {
    type   = string
    default = "t3.micro"
}

variable "region" {
    type    = string
    default = "us-east-1"
}

variable "instance_ami" {
    type    = string

    default = "ami-0b6c6ebed2801a5cb"
}

# variable for RDS instance
variable "DB_NAME" {
    default = "db_ayub"
}
variable "DB_USER" {
    default = "admin_ayub"
}
variable "DB_PASSWORD" {
    type = string
    sensitive = true
}
variable "instance_class" {
    type    = string
    default = "db.t3.micro"
}

variable "DB_HOST" {
    default = ""
}

variable "db_endpoint" {
    default = ""
}

variable "WEB_DIR" {
    default = "/var/www/html"
}


# variable for security group

