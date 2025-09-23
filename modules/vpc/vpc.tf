# create vpc
# terraform aws create vpc
resource "aws_vpc" "vpc" {
  cidr_block              = var.vpc_cidr
  instance_tenancy        = var.instance_tenancy
  enable_dns_hostnames    = var.enable_dns_hostnames

  tags      = {
    Name    = "dev vpc"
  }
}

# create internet gateway and attach it to vpc
# terraform aws create internet gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id    = aws_vpc.vpc.id

  tags      = {
    Name    = "dev internet gateway"
  }
}

# create public subnet az1
# terraform aws create subnet
resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_az1_cidr
  availability_zone       = var.availability_zone_1a
  map_public_ip_on_launch = true

  tags      = {
    Name    = "public subnet az1"
  }
}


# create public subnet az2
# terraform aws create subnet
resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_az2_cidr
  availability_zone       = var.availability_zone_1b
  map_public_ip_on_launch = true


  tags      = {
    Name    = "public subnet az2"
  }
}

# create route table and add public route
# terraform aws create route table
resource "aws_route_table" "public_route_table" {
  vpc_id       = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags       = {
    Name     = "public route table"
  }
}

# associate public subnet az1 to "public route table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public_subnet_az1_route_table_association" {
  subnet_id           = aws_subnet.public_subnet_az1.id
  route_table_id      = aws_route_table.public_route_table.id
}

# associate public subnet az2 to "public route table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public_subnet_2_route_table_association" {
  subnet_id           = aws_subnet.public_subnet_az2.id
  route_table_id      = aws_route_table.public_route_table.id
}

# create private app subnet az1
# terraform aws create subnet
resource "aws_subnet" "private_app_subnet_az1" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.private_app_subnet_az1_cidr
  availability_zone        = var.availability_zone_1a
  map_public_ip_on_launch  = var.map_public_ip_on_launch

  tags      = {
    Name    = "private app subnet az1"
  }
}

# create private app subnet az2
# terraform aws create subnet
resource "aws_subnet" "private_app_subnet_az2" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.private_app_subnet_az2_cidr
  availability_zone        = var.availability_zone_1b
  map_public_ip_on_launch  = var.map_public_ip_on_launch

  tags      = {
    Name    = "private app subnet az2"
  }
}

# create private data subnet az1
# terraform aws create subnet
resource "aws_subnet" "private_data_subnet_az1" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.private_data_subnet_az1_cidr
  availability_zone        = var.availability_zone_1a
  map_public_ip_on_launch  = var.map_public_ip_on_launch

  tags      = {
    Name    = "private data subnet az1"
  }
}


# create private data subnet az2
# terraform aws create subnet
resource "aws_subnet" "private_data_subnet_az2" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.private_data_subnet_az2_cidr
  availability_zone        = var.availability_zone_1b
  map_public_ip_on_launch  = var.map_public_ip_on_launch

  tags      = {
    Name    = "private data subnet az2"
  }
}

# elastic ip for nat gateway in az1
resource "aws_eip" "nat_gateway_az1_eip" {
  domain = "vpc"
  depends_on = [ aws_internet_gateway.internet_gateway ]
  tags = {
    name = "nat gateway eip az1"
  }
  
}

# elastic ip for nat gateway in az2

resource "aws_eip" "nat_gateway_az2_eip" {
  domain = "vpc"
  depends_on = [ aws_internet_gateway.internet_gateway ]
  tags = {
    Name = "nat gateway eip az2"
  }

}


# create nat gateway for az1

resource "aws_nat_gateway" "nat_gateway_az1" {
  allocation_id = aws_eip.nat_gateway_az1_eip.id
  subnet_id = aws_subnet.public_subnet_az1.id
  tags = {
    name = "nat gateway az1"
  }
}

# create nat gateway for az2

resource "aws_nat_gateway" "nat_gateway_az2" {
  allocation_id = aws_eip.nat_gateway_az2_eip.id
  subnet_id = aws_subnet.public_subnet_az2.id
  tags = {
    name = "nat gateway az2"
  }
}

# create route table and route for az1 and route traffic through ngw

resource "aws_route_table" "private_route_table_az1" {
  vpc_id = aws_vpc.vpc.id
  route {
  cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gateway_az1.id
  }
  tags = {
    name = " private route table az1"
  }
  
}

 #create route table and route for az2 to route traffic to ngw
resource "aws_route_table" "private_route_table_az2" {
  vpc_id = aws_vpc.vpc.id
  route {
  cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gateway_az2.id
  }
    tags = {
      name = "private route table az2"
  }

  
}

#associate az1 private app subnet with az1 private route table
resource "aws_route_table_association" "private_app_subnet_az1_association" {
  subnet_id = aws_subnet.private_app_subnet_az1.id
  route_table_id = aws_route_table.private_route_table_az1.id
}

# associate az1 private data subnet with az1 private route table

resource "aws_route_table_association" "private_data_subnet_az1_association" {
  subnet_id = aws_subnet.private_data_subnet_az1.id
  route_table_id = aws_route_table.private_route_table_az1.id
  
}

# associate az2 private app subnet with az2 private route table
resource "aws_route_table_association" "private_app_subnet_az2_association" {
  subnet_id = aws_subnet.private_app_subnet_az2.id
  route_table_id = aws_route_table.private_route_table_az2.id
  
}

# associate az2 private data subnet with az2 private route table
resource "aws_route_table_association" "private_data_subnet_az2_association" {
  subnet_id = aws_subnet.private_data_subnet_az2.id
  route_table_id = aws_route_table.private_route_table_az2.id

}



