# ---------- VPCs ----------

# Web Tier VPC (public resources)
resource "aws_vpc" "bs101_prod_app" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "bs101-prod-app-vpc"
  }
}

# App Tier VPC (private resources)
resource "aws_vpc" "bs101-prod" {
  cidr_block = "10.1.0.0/16"

  tags = {
    Name = "bs101-prod-vpc"
  }
}

# ---------- Internet Gateway & Route Table (Public) ----------

resource "aws_internet_gateway" "bs101_prod_app_igw" {
  vpc_id = aws_vpc.bs101_prod_app.id

  tags = {
    Name = "bs101-prod-app-igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.bs101_prod_app.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bs101_prod_app_igw.id
  }

  tags = {
    Name = "bs101-prod-app-public-rt"
  }
}

# ---------- Public Subnets ----------

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.bs101_prod_app.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "bs101-prod-app-public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.bs101_prod_app.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "bs101-prod-app-public-subnet-2"
  }
}

# ---------- Route Table Associations (Public Subnets) ----------

resource "aws_route_table_association" "public_subnet_assoc_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_subnet_assoc_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}

# ---------- Private Subnets (App/DB Tier) ----------

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.bs101-prod.id
  cidr_block              = "10.1.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = false

  tags = {
    Name = "bs101-prod-private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.bs101-prod.id
  cidr_block              = "10.1.2.0/24"
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = false

  tags = {
    Name = "bs101-prod-private-subnet-2"
  }
}

# ---------- Security Groups ----------

# Web Tier Security Group
resource "aws_security_group" "vpc_web_sg" {
  name        = "bs101-prod-web-sg"
  description = "Allow HTTP, HTTPS, and SSH"
  vpc_id      = aws_vpc.bs101_prod_app.id

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

  ingress {
    from_port   = 22
    to_port     = 22
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
    Name = "bs101-prod-web-sg"
  }
}

# App Tier Security Group
resource "aws_security_group" "vpc_app_sg" {
  name        = "bs101-prod-app-sg"
  description = "Allow HTTP from Web SG"
  vpc_id      = aws_vpc.bs101-prod.id

  ingress {
    description     = "Allow HTTP from Web Tier"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.vpc_web_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bs101-prod-app-sg"
  }
}
