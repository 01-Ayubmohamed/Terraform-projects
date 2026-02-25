
resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
      tags= {
        Name = "terraform_vpc"
      }
}

resource "aws_subnet" "public_subnet" {
    for_each = { for public_subnet in var.public_subnets : public_subnet.cidr_block => public_subnet }
    cidr_block = each.value.cidr_block
    vpc_id     = aws_vpc.main.id
    availability_zone = each.value.az
    map_public_ip_on_launch = true
    
}

resource "aws_subnet" "private_subnet" {
    for_each = { for private_subnet in var.private_subnets : private_subnet.cidr_block => private_subnet }
    cidr_block = each.value.cidr_block
    vpc_id     = aws_vpc.main.id
    availability_zone = each.value.az
    map_public_ip_on_launch = false
    
}

resource "aws_db_subnet_group" "db_subnet_group" {
    name       = var.db_subnet_group_name
    subnet_ids = [for db_subnet in aws_subnet.private_subnet : db_subnet.id]
    tags = {
        Name = "terraform_db_subnet_group"
    }
}

# Internet Gateway and Route Table
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "terraform_igw"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  for_each = aws_subnet.public_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.rt.id
}

