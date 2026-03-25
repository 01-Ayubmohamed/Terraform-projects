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

variable "my_ip" {
    description = "Your IP address for security group rules"
    sensitive = true 
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

variable "subnet_ids" {
    description = "List of subnet IDs, created by the VPC module"
    default     = []
}

variable "db_subnet_group_name" {
    description = "Name of the RDS subnet group"
    default     = "rds_subnet_group"
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

variable alb_sg {
    type = list(object({
        port        = number
        description = string
        protocol    = string          
        cidr_blocks = list(string)     
    }))

    default = [{
      port = 80 
      protocol = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
      description = "HTTPS acces"
    },
    
    {
      port = 443 
      protocol = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
      description = "HTTPS access"
    }
    ]
}

variable "target_group_arn" {
    default = ""
}






