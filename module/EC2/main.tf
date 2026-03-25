# Compute 
## resources for ec2 instance
resource "aws_instance" "wordpress_instance" {
    ami          =  var.instance_ami 
    instance_type = var.instance_type
    subnet_id    = var.public_subnet_ids[0]
    vpc_security_group_ids = [ aws_security_group.ec2_sg.id]

    
    
    

    user_data =     templatefile("${path.root}/cloud_init.yaml", {
            DB_NAME     =var.DB_NAME
            DB_USER     = var.DB_USER,  
            DB_PASSWORD = var.DB_PASSWORD,
            DB_HOST     = var.DB_HOST,
            web_dir     = var.WEB_DIR
    })
   

    tags = {
        Name = "terraform_wordpress_ec2_instance"
    }
    

}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2_security_group"
  description = "Security group for EC2 instance"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ec2_sg
    iterator = port 
    content {
      from_port   = port.value.port
      to_port     = port.value.port
      protocol    = port.value.protocol
      description = port.value.description
      cidr_blocks = lookup(port.value, "cidr_blocks", null)
      security_groups = lookup(port.value, "security_groups", null)
    }
    
  }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


