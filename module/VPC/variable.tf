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



