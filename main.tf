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
