# Networking
## resources for vpc 
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "terraform-vpc"
  }
}
## this section creates subnets, public and private, db subnet group. 
resource "aws_subnet" "public_subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
      Name = "terraform-public-subnet1"
    }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = false
    tags = {
      Name = "terraform-private-subnet1"
    }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = false
    tags = {
      Name = "terraform-private-subnet2"
    }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = local.db_subnet_group_name
  subnet_ids = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]

  tags = {
    Name = "terraform-db-subnet-group"
  }
}
# Internet Gateway and Route Table
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "terraform-igw"
  }
}
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.rt.id
}

# Compute 
## resources for ec2 instance
resource "aws_instance" "wordpress_instance" {
    ami          =  local.instance_ami 
    instance_type = var.instance_type
    subnet_id     = aws_subnet.public_subnet1.id
    security_groups = [aws_security_group.world_sg.name]

    user_data     = file("userdata.sh")

    tags = {
        Name = "terraform-wordpress-ec2-instance"
    }

}


## resource for rds 
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = local.DB_NAME
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = local.instance_class
  username             = local.DB_USERNAME
  password             = local.DB_PASSWORD
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  db_subnet_group_name = local.db_subnet_group_name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]


}

# Security group for ec2 instance to allow http and https traffic 
resource "aws_security_group" "world_sg" {
    name        = "terraform-world-sg"
    description = "Security group for allowing all inbound and outbound traffic"
    vpc_id      = aws_vpc.main.id
  # ... other configuration ...

    ingress {
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }
    
    ingress {
        from_port        = 443
        to_port          = 443
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" 
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

# security group for rds to allow access from ec2 instance
resource "aws_security_group" "rds_sg" {
    name        = "terraform-rds-sg"
    description = "Security group for RDS allowing access from EC2 instance"
    vpc_id      = aws_vpc.main.id

    ingress {
        from_port        = 3306
        to_port          = 3306
        protocol         = "tcp"
        security_groups  = [aws_security_group.world_sg.id]
    }

  egress {
     from_port        = 0
    to_port          = 0
    protocol         = "-1" 
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
