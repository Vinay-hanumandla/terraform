resource "aws_vpc" "dev-vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name      = "dev-vpc"
    Cost      = "dev-env"
    Terraform = "true"
  }
}

resource "aws_internet_gateway" "dev-igw" {
  vpc_id = aws_vpc.dev-vpc.id

  tags = {
    Name      = "dev-igw"
    Cost      = "dev-env"
    Terraform = "true"
  }
}



resource "aws_subnet" "dev-pub-sub" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = var.pub_sub_cidr
  availability_zone       = var.pub_sub_az
  map_public_ip_on_launch = true
  tags = {
    Name      = "dev-pub-sub"
    Cost      = "dev-env"
    Terraform = "true"
  }
}

resource "aws_subnet" "dev-pvt-sub-1" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = var.pvt_sub_cidr_1
  availability_zone       = var.pvt_sub_az_1
  map_public_ip_on_launch = false
  tags = {
    Name      = "dev-pvt-sub-1"
    Cost      = "dev-env"
    Terraform = "true"
  }
}

resource "aws_subnet" "dev-pvt-sub-2" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = var.pvt_sub_cidr_2
  availability_zone       = var.pvt_sub_az_2
  map_public_ip_on_launch = false
  tags = {
    Name      = "dev-pvt-sub-2"
    Cost      = "dev-env"
    Terraform = "true"
  }
}

#eip
resource "aws_eip" "eip_nat" {
  domain = "vpc"
}

#nat gateway
resource "aws_nat_gateway" "dev-nat" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id     = aws_subnet.dev-pub-sub.id
}


#route_table
resource "aws_route_table" "dev-pub-rt" {
  vpc_id = aws_vpc.dev-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-igw.id
  }
}

#rt association

resource "aws_route_table_association" "pub-rt-ass" {
  subnet_id      = aws_subnet.dev-pub-sub.id
  route_table_id = aws_route_table.dev-pub-rt.id
}


# priv route_table


resource "aws_route_table" "dev-pvt-rt-1" {
  vpc_id = aws_vpc.dev-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.dev-nat.id
  }
}

#rt association

resource "aws_route_table_association" "pvt-rt-ass-1" {
  subnet_id      = aws_subnet.dev-pvt-sub-1.id
  route_table_id = aws_route_table.dev-pvt-rt-1.id
}



resource "aws_route_table" "dev-pvt-rt-2" {
  vpc_id = aws_vpc.dev-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.dev-nat.id
  }
}

#rt association

resource "aws_route_table_association" "pvt-rt-ass-2" {
  subnet_id      = aws_subnet.dev-pvt-sub-2.id
  route_table_id = aws_route_table.dev-pvt-rt-2.id
}
