module "VPC" {
  source = "../module/VPC"
  vpc_cidr        = var.vpc_cidr 
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  db_subnet_group_name = var.db_subnet_group_name
}


module "ALB" {
  source = "../module/ALB"
  vpc_id          = module.VPC.vpc_id
  subnet_ids      = module.VPC.public_subnet_ids
  alb_sg          = var.alb_sg
  ec2_instance_id = module.EC2.ec2_instance_id
}

module "RDS" {
  source = "../module/RDS"
    vpc_id          = module.VPC.vpc_id
    db_subnet_group_name = module.VPC.db_subnet_group_name
    DB_NAME         = var.DB_NAME
    DB_USER         = var.DB_USER
    DB_PASSWORD     = var.DB_PASSWORD
    instance_class  = var.instance_class
    ec2_sg_id         = module.EC2.ec2_sg_id

}


module "EC2" {
  source = "../module/EC2"
  vpc_id          = module.VPC.vpc_id
  public_subnet_ids  = module.VPC.public_subnet_ids
  DB_USER         = var.DB_USER
  DB_PASSWORD     = var.DB_PASSWORD
  DB_NAME         = var.DB_NAME
  DB_HOST         = module.RDS.db_endpoint
  WEB_DIR         = var.WEB_DIR
  ec2_sg      = [
    {
      port        = 22
      description = "Allow SSH from my IP"
      protocol    = "tcp"
      cidr_blocks = [var.my_ip]
    },
    {
      port        = 80
      description = "Allow HTTP from anywhere"
      protocol    = "tcp"
      security_groups = [module.ALB.alb_sg_id]

    }
  ]
}


