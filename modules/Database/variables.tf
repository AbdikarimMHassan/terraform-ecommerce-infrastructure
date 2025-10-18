

# credentials for the db

variable "db_name" {
    type = string
    default = "abdikarimdb"
    description = "name of db subnet"
}
  





# Networking

# the subnet where the db will be placed in
# this variable will have the ids of the db subnets passed at the root
variable "subnet_ids" {
    type = list(string)
    description = "the subnet where the db will be created"

}

# the db sg to allow inbound traffic from app to db and outbound to anywhere
variable "db_sg_ids" {
    type = list(string)
    description = "the security group to connect app to db"
  
}

# db engine configuration

variable "engine" {
    type = string
    default = "mysql"
  description = "engine for the rds db"
}

variable "enginer_version" {
    type = string
    default = "8.0"
    description = "the enginer version for the rds db"
}
# configuration the instance used to host the db

variable "rds_instance_class" {
    type = string
    default = "db.t3.micro"
    description = "db instance size"
}




# tag for our db
variable "environment" {
    type = string
    default = "dev"
}


# DB snapshot identifer
variable "db_snapshot_identifier" {
    type = string
    default = "arn:aws:rds:eu-north-1:779846800049:snapshot:my-db-final-snapshot-abdikarim2025"
    description = "application DB snapshot"
}


variable "db_instance_identifier" {
    type = string
    default = "mydatabase"
    description = "RDS instance identifier"
  
}

variable "multi_az_deployment" {
    type = bool
    default = false
    description = "create a standby DB"

}
  
