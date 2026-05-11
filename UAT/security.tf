# IAM Role for EC2 to allow access to AWS services
resource "aws_iam_role" "mc-uat_ec2_role" {
  name = "mc-uat_ec2_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Effect = "Allow"
      Sid    = ""
    }]
  })

  tags = {
    Name = "mc-uat_ec2_role"
  }
}

# IAM Policy to allow access to Secrets Manager
resource "aws_iam_policy" "mc-uat_secrets_manager_policy" {
  name        = "mc-uat-app-secrets-manager-policy"
  description = "Allow EC2 to access Secrets Manager"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ],
        Resource = "*"
      }
    ]
  })
}

# Attach Secrets Manager Policy to the EC2 Role
resource "aws_iam_role_policy_attachment" "mc-uat_attach_secrets_policy" {
  role       = aws_iam_role.mc-uat_ec2_role.name
  policy_arn = aws_iam_policy.mc-uat_secrets_manager_policy.arn
}

#resource "aws_secretsmanager_secret" "mc-uat_db_credentials" {
#  name        = "mc-uat-app-db-credentials"
#  description = "Database credentials for the application"
#}

# Store secret values (username/password) in Secrets Manager
#resource "aws_secretsmanager_secret_version" "mc-uat_db_credentials_version" {
#  secret_id     = aws_secretsmanager_secret.mc-uat_db_credentials.id
#  secret_string = jsonencode({
#    username = "admin",
#    password = "password123" # Replace with a secure password
#  })
#}

# Security Group for the Web Server
resource "aws_security_group" "mc-uat_web_sg" {
  name   = "mc-uat-app-web-sg"
  vpc_id = aws_vpc.mc-uat.id # Ensure this VPC is declared

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
