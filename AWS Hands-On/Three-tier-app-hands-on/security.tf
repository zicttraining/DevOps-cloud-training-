# IAM Role for EC2 to allow access to AWS services
resource "aws_iam_role" "bme_uat_app_ec2_role" {
  name = "bme_uat_app_ec2_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Effect    = "Allow"
      Sid       = ""
    }]
  })

  tags = {
    Name = "bme_uat_app_ec2_role"
  }
}

# IAM Policy to allow access to Secrets Manager
resource "aws_iam_policy" "bme_uat_app_secrets_manager_policy" {
  name        = "bme-uat-app-secrets-manager-policy"
  description = "Allow EC2 to access Secrets Manager"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ],
        Resource = "*"
      }
    ]
  })
}

# Attach Secrets Manager Policy to the EC2 Role
resource "aws_iam_role_policy_attachment" "bme_uat_app_attach_secrets_policy" {
  role       = aws_iam_role.bme_uat_app_ec2_role.name
  policy_arn = aws_iam_policy.bme_uat_app_secrets_manager_policy.arn
}

# Create a secret in AWS Secrets Manager
resource "aws_secretsmanager_secret" "bme_uat_app_db_credentials" {
  name        = "bme-uat-app-db-credentials"
  description = "Database credentials for the application"
}

# Store secret values (username/password) in Secrets Manager
resource "aws_secretsmanager_secret_version" "bme_uat_app_db_credentials_version" {
  secret_id     = aws_secretsmanager_secret.bme_uat_app_db_credentials.id
  secret_string = jsonencode({
    username = "admin",
    password = "password123" # Replace with a secure password
  })
}

# Security Group for the Web Server
resource "aws_security_group" "bme_uat_app_web_sg" {
  name   = "bme-uat-app-web-sg"
  vpc_id = aws_vpc.bme_uat_app.id # Ensure this VPC is declared

  # Allow HTTP traffic on port 80 from any IP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outbound traffic to any destination
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}