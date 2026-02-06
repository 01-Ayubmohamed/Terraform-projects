# Networking
## resources for vpc 
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "terraform-vpc"
  }
}

## this section creates subnets, public and private, db subnet group. 
resource "aws_subnet" "public_subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidrs[0]
    availability_zone = var.azs[0]
    map_public_ip_on_launch = true
    tags = {
      Name = "terraform-public-subnet1"
    }
}
resource "aws_subnet" "public_subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidrs[1]
    availability_zone = var.azs[1]
    map_public_ip_on_launch = true
    tags = {
      Name = "terraform-public-subnet2"
    }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidrs[2]
    availability_zone = var.azs[0]
    map_public_ip_on_launch = false
    tags = {
      Name = "terraform-private-subnet1"
    }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidrs[3]
    availability_zone = var.azs[1]
    map_public_ip_on_launch = false
    tags = {
      Name = "terraform-private-subnet2"
    }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = var.db_subnet_group_name
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
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.rt.id
}
resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.rt.id
}
resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.rt.id
}

# Security group for ec2 instance to allow http and https traffic 
resource "aws_security_group" "ec2_sg" {
    name        = "terraform-ec2-sg"
    description = "Security group for allowing all inbound and outbound traffic"
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

    ingress {
        from_port        = 3306
        to_port          = 3306
        protocol         = "tcp"
        security_groups  = [aws_security_group.ec2_sg.id]
    }

  egress {
     from_port        = 0
    to_port          = 0
    protocol         = "-1" 
    cidr_blocks      = ["0.0.0.0/0"]
  }
}