# Ensure that the VPC is declared
resource "aws_vpc" "bme_uat_app" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "bme-uat-app-vpc"
  }
}

# Public EC2 Instances (Web Tier)
resource "aws_instance" "bme_uat_web_1" {
  ami             = "ami-0c55b159cbfafe1f0"
  instance_type   = "t3.micro"
  subnet_id       = aws_subnet.public_subnet_1.id
  security_groups = [aws_security_group.vpc_web_sg.id]

  tags = {
    Name = "bme-uat-web-1"
  }

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<html><body><h1>BME UAT Application - Web Server 1</h1></body></html>" > /var/www/html/index.html
  EOF
}

resource "aws_instance" "bme_uat_web_2" {
  ami             = "ami-0c55b159cbfafe1f0"
  instance_type   = "t3.micro"
  subnet_id       = aws_subnet.public_subnet_2.id
  security_groups = [aws_security_group.vpc_web_sg.id]

  tags = {
    Name = "bme-uat-web-2"
  }

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<html><body><h1>BME UAT Application - Web Server 2</h1></body></html>" > /var/www/html/index.html
  EOF
}

# Private EC2 Instances (App Tier)
resource "aws_instance" "bme_uat_app_1" {
  ami             = "ami-0c55b159cbfafe1f0"
  instance_type   = "t3.micro"
  subnet_id       = aws_subnet.private_subnet_1.id
  security_groups = [aws_security_group.vpc_app_sg.id]

  tags = {
    Name = "bme-uat-app-1"
  }

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<html><body><h1>BME UAT Application - App Server 1</h1></body></html>" > /var/www/html/index.html
  EOF
}

resource "aws_instance" "bme_uat_app_2" {
  ami             = "ami-0c55b159cbfafe1f0"
  instance_type   = "t3.micro"
  subnet_id       = aws_subnet.private_subnet_2.id
  security_groups = [aws_security_group.vpc_app_sg.id]

  tags = {
    Name = "bme-uat-app-2"
  }

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<html><body><h1>BME UAT Application - App Server 2</h1></body></html>" > /var/www/html/index.html
  EOF
}

# Lambda Function as Application Server
resource "aws_lambda_function" "bme_uat_app_lambda" {
  function_name     = "bme-uat-app-lambda"
  runtime           = "nodejs14.x"
  handler           = "index.handler"
  role              = aws_iam_role.bme_uat_app_ec2_role.arn  # Ensure this IAM role is declared
  filename          = "lambda.zip"
  source_code_hash  = filebase64sha256("lambda.zip")

  # VPC configuration for Lambda to access resources in private subnets
  vpc_config {
    subnet_ids         = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
    security_group_ids = [aws_security_group.lambda_sg.id]
  }
}

# Security Groups
resource "aws_security_group" "vpc_web_sg" {
  vpc_id = aws_vpc.bme_uat_app.id

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
    Name = "bme-uat-web-sg"
  }
}

resource "aws_security_group" "vpc_app_sg" {
  vpc_id = aws_vpc.bme_uat_app.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # Allow internal traffic
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bme-uat-app-sg"
  }
}

resource "aws_security_group" "lambda_sg" {
  vpc_id = aws_vpc.bme_uat_app.id

  ingress {
    from_port   = 443
    to_port     = 443
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
    Name = "bme-uat-lambda-sg"
  }
}
