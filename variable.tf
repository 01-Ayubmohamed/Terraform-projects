variable "instance_type" {
    type   = string
    default = "t3.micro"
}

variable "region" {
    type    = string
    default = "us-east-1"
}


locals {
    instance_ami = "ami-0b6c6ebed2801a5cb"
}

locals {
    DB_NAME = "db_ayub"
    DB_USERNAME = "admin_ayub"
    DB_PASSWORD = "123"
    DB_HOST = "mydbinstance.123456789012.us-east-1.rds.amazonaws.com"
    instance_class = "db.t3.micro"
    db_subnet_group_name = "rds-subnet-group"
}


# DB_NAME="${db_name}"
# DB_USER="${db_username}"
# DB_PASSWORD="${db_password}"
# DB_HOST="${db_endpoint}"

# WEB_DIR="/var/www/html"


