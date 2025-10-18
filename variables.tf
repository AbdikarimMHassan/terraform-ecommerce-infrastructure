# name of vpc
variable "vpc_name" {
  type           = string
  description    = "vpc cidr block"
}


# the ipv4 cidr block allocated to the vpc
variable "vpc_cidr" {
    type         = string
    description  = "vpc cidr block"
    
}

variable "instance_tenancy" {
    type         = string
    default      = "default"
}

variable "enable_dns_hostnames" {
    type         = bool
    default = true
  
}
variable "map_public_ip_on_launch" {
    type = bool
    default = false
  
}
# subnet cird's : 6 in total across 2 az's

variable "public_subnet_az1_cidr" {
    type = string
  
}



variable "public_subnet_az2_cidr" {
    type = string
  
}



variable "private_app_subnet_az1_cidr" {
    type = string
  
}



variable "private_app_subnet_az2_cidr" {
    type = string
  
}



variable "private_data_subnet_az1_cidr" {
    type = string
  
}



variable "private_data_subnet_az2_cidr" {
    type = string
}

# The availability  zones for our resources

variable "availability_zone_1a" {
    type = string
  
}

variable "availability_zone_1b" {
    type = string
  
}





