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
  vpc_id = aws_vpc.main_vpc.id

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

# RDS Database Instance for storing application data
resource "aws_db_instance" "bme-uat-app_db" {
  identifier              = "bme-uat-app-db"    # Database instance identifier
  engine                  = "mysql"             # Database engine type
  instance_class          = "db.t3.micro"       # Cost-effective instance type
  allocated_storage       = 20                  # Storage capacity in GB
  db_subnet_group_name    = aws_db_subnet_group.bme-uat-app_main.name # DB subnet group
  vpc_security_group_ids  = [aws_security_group.bme-uat-app_db_sg.id] # Attach security group
  username                = "admin"             # Database admin username
  password                = "password123"       # Database admin password (replace for production)
  skip_final_snapshot     = true                # Skip snapshot on delete
}
