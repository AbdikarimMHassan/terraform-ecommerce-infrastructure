
# expose these values to other modules to use
output "vpc_id" {
    value = aws_vpc.vpc.id
  
}

# public subenets az1 and az2
output "public_subnet_ids" {
    value = [
        aws_subnet.public_subnet_az1.id,
        aws_subnet.public_subnet_az2.id,
    ]
  
}

# private app subnets
output "private_app_subnet_ids" {
    value = [
        aws_subnet.private_app_subnet_az1.id,
        aws_subnet.private_app_subnet_az2.id,
    ]
  
}

# private data subnets.
output "private_data_subnet" {
    value = [
        aws_subnet.private_data_subnet_az1.id,
        aws_subnet.private_data_subnet_az2.id,
    ]
  
}