resource "aws_db_subnet_group" "this" {
  name       = "${var.name_prefix}-db-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = merge(var.tags, { Name = "${var.name_prefix}-db-subnet-group" })
}

resource "aws_db_instance" "this" {
  identifier                 = "${var.name_prefix}-db"
  allocated_storage          = var.allocated_storage
  storage_type               = "gp3"
  engine                     = "mysql"
  engine_version             = var.engine_version
  instance_class             = var.instance_class
  db_name                    = var.database_name
  username                   = var.database_username
  password                   = var.database_password
  db_subnet_group_name       = aws_db_subnet_group.this.name
  vpc_security_group_ids     = [var.security_group_id]
  storage_encrypted          = true
  publicly_accessible        = false
  skip_final_snapshot        = var.skip_final_snapshot
  deletion_protection        = var.deletion_protection
  auto_minor_version_upgrade = true
  backup_retention_period    = var.backup_retention_period
  tags                       = merge(var.tags, { Name = "${var.name_prefix}-db" })
}
