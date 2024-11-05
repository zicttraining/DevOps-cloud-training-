provider "aws" {
  region = var.region_1
  alias  = "region1"
}

provider "aws" {
  region = var.region_2
  alias  = "region2"
}

# VPC in Region 1
resource "aws_vpc" "vpc_1" {
  provider = aws.region1
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet_1" {
  provider                  = aws.region1
  vpc_id                    = aws_vpc.vpc_1.id
  cidr_block                = "10.0.1.0/24"
  availability_zone         = "us-west-1a"
  map_public_ip_on_launch   = true
}

resource "aws_internet_gateway" "igw_1" {
  provider = aws.region1
  vpc_id = aws_vpc.vpc_1.id
}

resource "aws_route_table" "route_table_1" {
  provider = aws.region1
  vpc_id   = aws_vpc.vpc_1.id
}

resource "aws_route" "route_1" {
  provider             = aws.region1
  route_table_id       = aws_route_table.route_table_1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id           = aws_internet_gateway.igw_1.id
}

resource "aws_route_table_association" "subnet_1_association" {
  provider       = aws.region1
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.route_table_1.id
}

# Security Group for Region 1
resource "aws_security_group" "sg_1" {
  provider = aws.region1
  vpc_id   = aws_vpc.vpc_1.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Web Server in Region 1
resource "aws_instance" "web_1" {
  provider = aws.region1
  ami           = var.ami2
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet_1.id
  vpc_security_group_ids = [aws_security_group.sg_1.id]
  associate_public_ip_address = true
}

# VPC in Region 2
resource "aws_vpc" "vpc_2" {
  provider = aws.region2
  cidr_block = "10.1.0.0/16"
}

resource "aws_subnet" "subnet_2" {
  provider                  = aws.region2
  vpc_id                    = aws_vpc.vpc_2.id
  cidr_block                = "10.1.1.0/24"
  availability_zone         = "us-east-1b"
  map_public_ip_on_launch   = true
}

resource "aws_internet_gateway" "igw_2" {
  provider = aws.region2
  vpc_id = aws_vpc.vpc_2.id
}

resource "aws_route_table" "route_table_2" {
  provider = aws.region2
  vpc_id   = aws_vpc.vpc_2.id
}

resource "aws_route" "route_2" {
  provider             = aws.region2
  route_table_id       = aws_route_table.route_table_2.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id           = aws_internet_gateway.igw_2.id
}

resource "aws_route_table_association" "subnet_2_association" {
  provider       = aws.region2
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.route_table_2.id
}

# Security Group for Region 2
resource "aws_security_group" "sg_2" {
  provider = aws.region2
  vpc_id   = aws_vpc.vpc_2.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Web Server in Region 2
resource "aws_instance" "web_2" {
  provider = aws.region2
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet_2.id
  vpc_security_group_ids = [aws_security_group.sg_2.id]
  associate_public_ip_address = true
}

# VPC Peering Connection
resource "aws_vpc_peering_connection" "peering" {
  provider      = aws.region1
  vpc_id        = aws_vpc.vpc_1.id
  peer_vpc_id   = aws_vpc.vpc_2.id
  peer_region   = var.region_2
  #auto_accept   = true
}

# Routes for VPC Peering
resource "aws_route" "peer_route_1" {
  provider                = aws.region1
  route_table_id          = aws_route_table.route_table_1.id
  destination_cidr_block  = "10.1.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
}

resource "aws_route" "peer_route_2" {
  provider                = aws.region2
  route_table_id          = aws_route_table.route_table_2.id
  destination_cidr_block  = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
}

