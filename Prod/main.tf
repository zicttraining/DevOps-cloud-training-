resource "aws_vpc" "prod" {
  cidr_block           = "10.2.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "mc-Prod-VPC", Environment = "Production", Client = "MaidCentral" }
}

resource "aws_subnet" "public_1a" {
  vpc_id            = aws_vpc.prod.id
  cidr_block        = "10.2.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = { Name = "mc-Prod-Public-1a" }
}
resource "aws_subnet" "public_1b" {
  vpc_id            = aws_vpc.prod.id
  cidr_block        = "10.2.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = { Name = "mc-Prod-Public-1b" }
}
resource "aws_subnet" "private_app_1a" {
  vpc_id            = aws_vpc.prod.id
  cidr_block        = "10.2.3.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "mc-Prod-Private-App-1a" }
}
resource "aws_subnet" "private_app_1b" {
  vpc_id            = aws_vpc.prod.id
  cidr_block        = "10.2.4.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "mc-Prod-Private-App-1b" }
}
resource "aws_subnet" "private_db_1a" {
  vpc_id            = aws_vpc.prod.id
  cidr_block        = "10.2.5.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "mc-Prod-Private-DB-1a" }
}
resource "aws_subnet" "private_db_1b" {
  vpc_id            = aws_vpc.prod.id
  cidr_block        = "10.2.6.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "mc-Prod-Private-DB-1b" }
}

resource "aws_internet_gateway" "prod" {
  vpc_id = aws_vpc.prod.id
  tags   = { Name = "mc-Prod-IGW" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.prod.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod.id
  }
  tags = { Name = "mc-Prod-Public-RT" }
}

resource "aws_route_table_association" "pub_1a" {
  subnet_id      = aws_subnet.public_1a.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "pub_1b" {
  subnet_id      = aws_subnet.public_1b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "alb_sg" {
  name   = "mc-Prod-ALB-SG"
  vpc_id = aws_vpc.prod.id
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
  tags = { Name = "mc-Prod-ALB-SG" }
}

resource "aws_security_group" "ec2_sg" {
  name   = "mc-Prod-EC2-SG"
  vpc_id = aws_vpc.prod.id
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "mc-Prod-EC2-SG" }
}

resource "aws_security_group" "db_sg" {
  name   = "mc-Prod-DB-SG"
  vpc_id = aws_vpc.prod.id
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "mc-Prod-DB-SG" }
}

resource "aws_launch_template" "prod" {
  name_prefix   = "mc-Prod-LT-"
  image_id      = "ami-0c1e21d82fe9c9336"
  instance_type = "t3.micro"
  tag_specifications {
    resource_type = "instance"
    tags = { Name = "mc-Prod-Web", Environment = "Production" }
  }
}

resource "aws_autoscaling_group" "prod" {
  name                = "mc-Prod-ASG"
  desired_capacity    = 2
  min_size            = 2
  max_size            = 6
  vpc_zone_identifier = [aws_subnet.public_1a.id, aws_subnet.public_1b.id]
  launch_template {
    id      = aws_launch_template.prod.id
    version = "$Latest"
  }
  tag {
    key                 = "Environment"
    value               = "Production"
    propagate_at_launch = true
  }
}

resource "aws_db_subnet_group" "prod" {
  name       = "mc-prod-db-subnet-group"
  subnet_ids = [aws_subnet.private_db_1a.id, aws_subnet.private_db_1b.id]
  tags = { Name = "mc-Prod-DB-Subnet-Group" }
}

resource "aws_db_instance" "prod" {
  identifier             = "mc-prod-db"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  storage_encrypted      = true
  multi_az               = true
  username               = "admin"
  password               = "Change_Me_Now_123!"
  db_subnet_group_name   = aws_db_subnet_group.prod.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot    = true
  tags = { Name = "mc-Prod-RDS", Environment = "Production" }
}