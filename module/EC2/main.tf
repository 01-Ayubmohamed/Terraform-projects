# Compute 
## resources for ec2 instance
resource "aws_instance" "wordpress_instance" {
    ami          =  var.instance_ami 
    instance_type = var.instance_type
    subnet_id     = var.public_subnet_ids[0]
    
  

    user_data     = templatefile("userdata.sh", {
        DB_NAME     = var.DB_NAME,
        DB_USER     = var.DB_USER,  
        DB_PASSWORD = var.DB_PASSWORD,
         DB_HOST    = var.db_endpoint,
        db_endpoint = var.db_endpoint,
        web_dir     = var.WEB_DIR
    })
    security_groups = [var.Ec2_sg_id]
   

    tags = {
        Name = "terraform-wordpress-ec2-instance"
    }

}


