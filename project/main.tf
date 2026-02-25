module "VPC" {
  source = "../module/VPC"
  vpc_id          = var.vpc_id
  vpc_cidr        = var.vpc_cidr
  az              = var.azs  
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  ec2_sg_id       = var.ec2_sg_id 
  rds_sg          = var.rds_sg 
}

module "RDS" {
  source = "../module/RDS"
    vpc_id          = module.VPC.vpc_id
    DB_NAME         = var.DB_NAME
    DB_USER         = var.DB_USER
    DB_PASSWORD     = var.DB_PASSWORD
    rds_sg_id       = module.VPC.rds_sg_id
    instance_class  = var.instance_class

}


module "EC2" {
  source = "../module/EC2"
  vpc_id          = var.vpc_id
  az              = var.azs
  DB_PASSWORD     = var.DB_PASSWORD
  DB_NAME         = var.DB_NAME
  DB_HOST         = var.DB_HOST 
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  ec2_sg_id       = module.VPC.ec2_sg_id
  
}


