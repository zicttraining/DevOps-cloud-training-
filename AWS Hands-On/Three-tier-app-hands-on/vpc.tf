# Define the VPC
resource "aws_vpc" "bme-uat-app" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "bme-uat-app-vpc"
  }
}

# Define Public Subnet 1
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.bme-uat-app.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "bme-uat-app-public-subnet-1"
  }
}

# Define Public Subnet 2
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.bme-uat-app.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = "bme-uat-app-public-subnet-2"
  }
}

# Define Private Subnet 1
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.bme-uat-app.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-west-2a"
  tags = {
    Name = "bme-uat-app-private-subnet-1"
  }
}

# Define Private Subnet 2
resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.bme-uat-app.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-west-2b"
  tags = {
    Name = "bme-uat-app-private-subnet-2"
  }
}

# Internet Gateway for public subnets
resource "aws_internet_gateway" "bme_uat_app_igw" {
  vpc_id = aws_vpc.bme-uat-app.id
  tags = {
    Name = "bme-uat-app-igw"
  }
}

# Public Route Table with route to Internet Gateway
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.bme-uat-app.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bme_uat_app_igw.id
  }
  tags = {
    Name = "bme-uat-app-public-rt"
  }
}

# Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.bme-uat-app.id
  tags = {
    Name = "bme-uat-app-private-rt"
  }
}

# Route Table Association for Public Subnet 1
resource "aws_route_table_association" "public_subnet_assoc_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

# Route Table Association for Public Subnet 2
resource "aws_route_table_association" "public_subnet_assoc_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}

# Route Table Association for Private Subnet 1
resource "aws_route_table_association" "private_subnet_assoc_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_rt.id
}

# Route Table Association for Private Subnet 2
resource "aws_route_table_association" "private_subnet_assoc_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_rt.id
}

# Security Group for Web Servers allowing HTTP traffic
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.bme-uat-app.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "bme-uat-app-web-sg"
  }
}

# Security Group for Application Servers allowing internal VPC traffic only
resource "aws_security_group" "app_sg" {
  vpc_id = aws_vpc.bme-uat-app.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "bme-uat-app-app-sg"
  }
}
