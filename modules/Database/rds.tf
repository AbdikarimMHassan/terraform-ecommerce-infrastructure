# create database subnet group
# terraform aws db subnet group
resource "aws_db_subnet_group" "dbsubnet_group" {
  name         = var.db_name
  subnet_ids   = var.subnet_ids
  description  = "subnets for database instance"

  tags   = {
    Name = "Database subnets"
  }
}

# get the latest db snapshot
# terraform aws data db snapshot
data "aws_db_snapshot" "latest_db_snapshot" {
  db_snapshot_identifier = var.db_snapshot_identifier
  most_recent            = true
  snapshot_type          = "manual"
}
# create database instance restored from db snapshots
# terraform aws db instance
resource "aws_db_instance" "database_instance" {
  instance_class          = var.rds_instance_class
  skip_final_snapshot     = false
  availability_zone       = "eu-north-1b"
  identifier              = var.db_instance_identifier
  snapshot_identifier     = data.aws_db_snapshot.latest_db_snapshot.id
  db_subnet_group_name    = aws_db_subnet_group.dbsubnet_group.name
  multi_az                = var.multi_az_deployment
  vpc_security_group_ids  = var.db_sg_ids
}