# Security Group for Web Server and Lambda
resource "aws_security_group" "bme-uat-app" {
  name   = "bme-uat-app"
  vpc_id = aws_vpc.main_vpc.id

  # Allow HTTP traffic on port 80 from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic for connecting to external resources
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance as Web Server with Apache installed
resource "aws_instance" "bme-uat-app" {
  ami           = "ami-0c55b159cbfafe1f0" # Replace with a valid AMI ID for your region
  instance_type = "t3.micro"               # Cost-effective instance type
  subnet_id     = aws_subnet.public_subnet.id # Place instance in public subnet
  security_groups = [aws_security_group.bme-uat-app.id] # Attach Security Group

  tags = {
    Name = "bme-uat-app" # Tag for identification
  }

  # User data script to install Apache and serve a basic HTML file
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<html><body><h1>BME UAT Application and Event Services in Colorado</h1></body></html>" > /var/www/html/index.html
  EOF
}

# Lambda Function as Application Server
resource "aws_lambda_function" "bme-uat-app_lambda" {
  function_name = "bme-uat-app-lambda"       # Lambda function name
  runtime       = "nodejs14.x"               # Lambda runtime environment
  handler       = "index.handler"            # Lambda handler function
  role          = aws_iam_role.ec2_role.arn  # IAM role with permissions

  # VPC configuration for Lambda to access resources in private subnets
  vpc_config {
    subnet_ids         = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id] # Private subnets
    security_group_ids = [aws_security_group.bme-uat-app.id] # Security group for Lambda
  }

  # Source code for Lambda function
  source_code_hash = filebase64sha256("lambda.zip") # Replace with your actual code file
}
