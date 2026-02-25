#variable for vpc 

variable vpc_id {
    description = "VPC ID, created by the VPC module"
    default       = ""
}

variable "vpc_cidr" {
   default = "10.0.0.0/16"
}
variable "azs" {
    description = "List of availability zones"
    default    = ["us-east-1a", "us-east-1b"]
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

variable "db_subnet_group_name" {
    default = "rds-subnet-group"
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
    default = ""
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

variable rds_sg {
    description = "security for rds"
    default = ""
}

variable "ec2_sg_id" {
  type = list(object({
    port        = number
    description = string
    protocol    = string           # Add this
    cidr_blocks = list(string)     # This should be inside the object
  }))
  
  description = "List of ports with descriptions to allow in the security group"
  
  default = [
    {
      port        = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTP access"
    },
    {
      port        = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTPS access"
    },
    {
      port        = 22
      protocol    = "tcp"
      cidr_blocks = ["31.54.72.180/32"]  # Your IP
      description = "SSH access"
    }
  ]
}


# variable for environment
variable "environment" {
    default = ""
}





