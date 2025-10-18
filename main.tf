module "vpc" {
    source = "./modules/vpc"
    vpc_cidr = var.vpc_cidr
    vpc_name = var.vpc_name
    availability_zone_1a = var.availability_zone_1a
    availability_zone_1b = var.availability_zone_1b
    public_subnet_az1_cidr = var.public_subnet_az1_cidr
    public_subnet_az2_cidr = var.public_subnet_az2_cidr
    private_app_subnet_az1_cidr = var.private_app_subnet_az1_cidr
    private_app_subnet_az2_cidr = var.private_app_subnet_az2_cidr
    private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
    private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr
  
}

module "security_groups" {
    source = "./modules/security-groups"
    vpc_id = module.vpc.vpc_id
  
}

module "Database" {
    source = "./modules/Database"
    subnet_ids = module.vpc.private_data_subnet
    db_sg_ids = [module.security_groups.rds_sg_id]
    
    
}

module "alb" {
    vpc_id = module.vpc.vpc_id
    source = "./modules/alb"
    name = "dev-alb"
    alb_type = "application"
    alb_sg_id = [module.security_groups.alb_sg_id]
    alb_subnet_ids = module.vpc.public_subnet_ids

}

module "sns" {
    source = "./modules/sns"
  
}

module "asg" {
    source = "./modules/asg"
    web_server_sg_id = [module.security_groups.web_server_sg_id]
    asg_subnet_id = module.vpc.private_app_subnet_ids
    alb_target_group_arn = module.alb.alb_target_group_arn
    sns_topic_arn = module.sns.sns_topic_arn
}


module "route53" {
    source = "./modules/Route53"
    alb_dns_name = module.alb.alb_dns_name
    alb_zone_id = module.alb.alb_zone_id
  
}