# DB Subnet Group (for high availability)
resource "aws_db_subnet_group" "bs101-prod_subnet_group" {
  name       = "bs101-prod-app-db-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]

  tags = {
    Name = "bs101-prod-app-db-subnet-group"
  }
}

# DB Security Group
resource "aws_security_group" "bs101-prod_db_sg" {
  name   = "bs101-prod-app-db-sg"
  vpc_id = aws_vpc.bs101-prod.id

  ingress {
    from_port       = 3306
    to_port         = 3306
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
    Name = "db-sg"
  }
}

# RDS Instance
resource "aws_db_instance" "bs101-prod_db" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  db_name                = "bs101proddb"
  username               = "admin"
  password               = "password123"
  db_subnet_group_name   = aws_db_subnet_group.bs101-prod_subnet_group.name
  vpc_security_group_ids = [aws_security_group.bs101-prod_db_sg.id]

  skip_final_snapshot = true

  tags = {
    Name = "bs101-prod-db"
  }
}
