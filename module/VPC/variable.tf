#variable for vpc 

variable "azs" {
    description = "List of availability zones"
    default    = ["us-east-1a", "us-east-1b"]
}

variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    default     = "10.0.0.0/16"
}

# variable for subnet 

variable "subnet_cidrs" {
    description = "List of subnet CIDR blocks"
    default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
}

variable "db_subnet_group_name" {
    default = "rds-subnet-group"
}
