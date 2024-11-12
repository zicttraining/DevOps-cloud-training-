# Public Subnet 1 in availability zone us-west-2a
resource "aws_subnet" "bme-uat-app_public_subnet_1" {
  vpc_id                  = aws_vpc.bme-uat-app.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "bme-uat-app-public-subnet-1"
  }
}

# Public Subnet 2 in availability zone us-west-2b
resource "aws_subnet" "bme-uat-app_public_subnet_2" {
  vpc_id                  = aws_vpc.bme-uat-app.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = "bme-uat-app-public-subnet-2"
  }
}

# Private Subnet 1 in availability zone us-west-2a
resource "aws_subnet" "bme-uat-app_private_subnet_1" {
  vpc_id            = aws_vpc.bme-uat-app.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-west-2a"
  tags = {
    Name = "bme-uat-app-private-subnet-1"
  }
}

# Private Subnet 2 in availability zone us-west-2b
resource "aws_subnet" "bme-uat-app_private_subnet_2" {
  vpc_id            = aws_vpc.bme-uat-app.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-west-2b"
  tags = {
    Name = "bme-uat-app-private-subnet-2"
  }
}

# Internet Gateway to enable internet access for public subnets
resource "aws_internet_gateway" "bme-uat-app_main_igw" {
  vpc_id = aws_vpc.bme-uat-app.id
  tags = {
    Name = "bme-uat-app-igw"
  }
}

# Public Route Table for directing traffic from public subnets to the internet
resource "aws_route_table" "bme-uat-app_public_rt" {
  vpc_id = aws_vpc.bme-uat-app.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bme-uat-app_main_igw.id
  }

  tags = {
    Name = "bme-uat-app-public-rt"
  }
}

# Associate Public Subnet 1 with the Public Route Table
resource "aws_route_table_association" "bme-uat-app_public_subnet_assoc_1" {
  subnet_id      = aws_subnet.bme-uat-app_public_subnet_1.id
  route_table_id = aws_route_table.bme-uat-app_public_rt.id
}

# Associate Public Subnet 2 with the Public Route Table
resource "aws_route_table_association" "bme-uat-app_public_subnet_assoc_2" {
  subnet_id      = aws_subnet.bme-uat-app_public_subnet_2.id
  route_table_id = aws_route_table.bme-uat-app_public_rt.id
}

# Private Route Table for private subnets (e.g., for NAT access)
resource "aws_route_table" "bme-uat-app_private_rt" {
  vpc_id = aws_vpc.bme-uat-app.id
  tags = {
    Name = "bme-uat-app-private-rt"
  }
}

# Associate Private Subnet 1 with the Private Route Table
resource "aws_route_table_association" "bme-uat-app_private_subnet_assoc_1" {
  subnet_id      = aws_subnet.bme-uat-app_private_subnet_1.id
  route_table_id = aws_route_table.bme-uat-app_private_rt.id
}

# Associate Private Subnet 2 with the Private Route Table
resource "aws_route_table_association" "bme-uat-app_private_subnet_assoc_2" {
  subnet_id      = aws_subnet.bme-uat-app_private_subnet_2.id
  route_table_id = aws_route_table.bme-uat-app_private_rt.id
}
