resource "aws_vpc" "devops" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name        = "${var.environment}-vpc"
  }
}


resource "aws_nat_gateway" "devops-nat" {
  allocation_id = aws_eip.elastic-ip.id
  subnet_id     = aws_subnet.devops-public.0.id

  tags = merge(
    {
      "Name" = "${var.environment}-nat"
    }
  )

  lifecycle {
    create_before_destroy = false
  }
}