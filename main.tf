module "VPC" {
  source = "./module/VPC"

  azs           = var.azs
  vpc_cidr      = var.vpc_cidr
  subnet_cidrs  = var.subnet_cidrs
  db_subnet_group_name = var.db_subnet_group_name
}

module "RDS" {
  source = "./module/RDS"
    vpc_id        = module.VPC.vpc_id
    DB_NAME       = var.DB_NAME
    DB_USER       = var.DB_USER
    DB_PASSWORD   = var.DB_PASSWORD
    rds_sg_id =  module.VPC.rds_sg_id
    instance_class   = var.instance_class
}


module "EC2" {
  source = "./module/EC2"
  subnet_ids = module.VPC.public_subnet_ids
  public_subnet_ids = module.VPC.public_subnet_ids
  Ec2_sg_id = module.VPC.EC2_sg_id
  vpc_id        = module.VPC.vpc_id
  DB_PASSWORD = var.DB_PASSWORD
  instance_type = var.instance_type
  instance_ami  = var.instance_ami
  DB_NAME       = var.DB_NAME
  DB_USER   = var.DB_USER
  WEB_DIR       = var.WEB_DIR
  db_endpoint   = module.RDS.db_endpoint
}

