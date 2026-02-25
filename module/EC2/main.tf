# Compute 
## resources for ec2 instance
resource "aws_instance" "wordpress_instance" {
    ami          =  var.instance_ami 
    instance_type = var.instance_type
    
    
  

   
    user_data =     templatefile("${path.root}/cloud_init.yaml", {
            DB_NAME     =var.DB_NAME
            DB_USER     = var.DB_USER,  
            DB_PASSWORD = var.DB_PASSWORD,
            DB_HOST     = var.DB_HOST
            web_dir     = var.WEB_DIR
    })
        vpc_security_group_ids = [var.ec2_sg_id]
   

    tags = {
        Name = "terraform_wordpress_ec2_instance"
    }

}

