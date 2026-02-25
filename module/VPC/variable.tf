# 2nd attempt 

# variable for vpc and subnets

# VPC variable

variable vpc_id {
    description = "VPC ID, created by the VPC module"
    default      = ""
}

variable "vpc_cidr" {
   default = "10.0.0.0/16"
}
variable "az" {
    description = "list of available azs in the region"
    type = list(string)
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
    default = "rds_subnet_group"
}


# variable for security group

variable "ec2_sg_id" {
  type = list(object({
    port        = number
    description = string
    protocol    = string          
    cidr_blocks = list(string)     
  }))
}


variable "rds_sg" {
    description = "security group for rds"
    type = string
}


