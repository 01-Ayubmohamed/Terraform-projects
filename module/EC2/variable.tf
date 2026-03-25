#variable for EC2 instance type

variable "vpc_id" {
    type = string
}
  

# variable for public subnets

variable "public_subnet_ids" {
   type = list(string)
}


variable "ec2_sg" {
  type = list(object({
    port        = number
    description = string
    protocol    = string 
    cidr_blocks = optional(list(string))        
    security_groups = optional(list(string))     
  }))
}



# variable for EC2 
variable "instance_type" {
    type   = string
    default = "t3.micro"
}

variable "instance_ami" {
    type    = string
    default = "ami-02dfbd4ff395f2a1b"
}

variable "my_ip" {
    type = string
    default = ""
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
