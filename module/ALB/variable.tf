variable "vpc_id" { 
    type = string 
}

variable "alb_sg" {
  description = "List of security group rules for ALB"
  type = list(object({
    port        = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "subnet_ids" {
    type = list(string)
}


variable "ec2_instance_id" {
    type = string
}
