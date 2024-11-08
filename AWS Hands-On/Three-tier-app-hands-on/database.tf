# Database Subnet Group with two private subnets for high availability
resource "aws_db_subnet_group" "bme-uat-app_main" {
  name       = "bme-uat-app-db-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id] # Use private subnets
  tags = {
    Name = "bme-uat-app-db-subnet-group"
  }
}

# Security Group for the Database to control access
resource "aws_security_group" "bme-uat-app_db_sg" {
  name   = "bme-uat-app-db-sg"
  vpc_id = aws_vpc.bme-uat-app.id

  # Allow MySQL access (port 3306) from the web server's security group
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id] 
  }

  # Allow outbound traffic to any destination
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDS Instance for the application database
# RDS Instance for the application database
resource "aws_db_instance" "bme_uat_app_db" {
  allocated_storage    = 20
  storage_type        = "gp2"
  engine              = "mysql"  # Change to your desired database engine
  engine_version      = "8.0"    # Specify the desired version
  instance_class      = "db.t3.micro"
  db_name             = "bmeuatdb"  # Corrected to use db_name instead of name
  username            = "admin"      # Username for the database
  password            = "password123" # Replace with a secure password
  db_subnet_group_name = aws_db_subnet_group.bme_uat_app_subnet_group.name # Adjust according to your subnet group
  vpc_security_group_ids = [aws_security_group.vpc_app_sg.id]  # Reference to the security group for RDS

  skip_final_snapshot = true

  tags = {
    Name = "bme_uat_app_db"
  }
}

# Optional: DB Subnet Group
resource "aws_db_subnet_group" "bme_uat_app_subnet_group" {
  name       = "bme-uat-app-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]

  tags = {
    Name = "bme-uat-app-subnet-group"
  }
}


