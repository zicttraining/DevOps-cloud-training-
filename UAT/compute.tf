# Public EC2 Instances (Web Tier)
resource "aws_instance" "bme_uat_web_1" {
  ami                    = "ami-066a7fbea5161f451"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.vpc_web_sg.id]

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
  ami                    = "ami-066a7fbea5161f451"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public_subnet_2.id
  vpc_security_group_ids = [aws_security_group.vpc_web_sg.id]

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
resource "aws_instance" "bs101-uat_1" {
  ami                    = "ami-066a7fbea5161f451"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private_subnet_1.id
  vpc_security_group_ids = [aws_security_group.vpc_app_sg.id]

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

resource "aws_instance" "bs101-uat_2" {
  ami                    = "ami-066a7fbea5161f451"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private_subnet_2.id
  vpc_security_group_ids = [aws_security_group.vpc_app_sg.id]

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
# resource "aws_lambda_function" "bs101-uat_lambda" {
#   function_name = "bme-uat-app-lambda"
#   runtime       = "nodejs18.x"         # Ensure the runtime is supported
#   handler       = "index.handler"      # Make sure this matches your code’s entry point

#   # S3 bucket and key where the Lambda code is stored
#   s3_bucket = "bme-uat-app2"           # Correct bucket name
#   s3_key    = "lambda.zip"             # Path to the Lambda package in S3

#   # Ensure the IAM role has permissions for Lambda execution
#   role = aws_iam_role.lambda_execution_role.arn
# }

# IAM Role for Lambda Execution
# resource "aws_iam_role" "lambda_execution_role" {
#   name = "bme-uat-app-lambda-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect    = "Allow",
#         Principal = { Service = "lambda.amazonaws.com" },
#         Action    = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# # Attach a policy to allow Lambda access to necessary resources
# resource "aws_iam_policy" "lambda_s3_access_policy" {
#   name        = "LambdaS3AccessPolicy"
#   description = "Policy for Lambda to access S3 bucket for code"

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Action = [
#           "s3:GetObject",
#           "s3:ListBucket"
#         ],
#         Resource = [
#           "arn:aws:s3:::bme-uat-app2",                    # Allow access to the bucket
#           "arn:aws:s3:::bme-uat-app2/lambda.zip"          # Allow access to the specific object
#         ]
#       }
#     ]
#   })
# }

# # Attach the policy to the Lambda execution role
# resource "aws_iam_role_policy_attachment" "lambda_s3_access_attachment" {
#   role       = aws_iam_role.lambda_execution_role.name
#   policy_arn = aws_iam_policy.lambda_s3_access_policy.arn
# }



