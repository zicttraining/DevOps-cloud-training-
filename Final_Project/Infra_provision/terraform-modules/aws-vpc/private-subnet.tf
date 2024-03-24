resource "aws_subnet" "devops-private" {
  count             = local.private_subnet_count
  vpc_id            = aws_vpc.devops.id
  availability_zone = element(local.availability_zones, count.index)

  cidr_block = cidrsubnet(
    signum(length(var.vpc_cidr_block)) == 1 ? var.vpc_cidr_block : "10.10.0.0/20",
    ceil(log(local.private_subnet_count * 2, 2)),
    count.index
  )

  tags = {
      "Name" = format("%s-%s", "subnet", element(local.availability_zones, count.index))
}
}


resource "aws_eip" "elastic-ip" {
  vpc   = true

  tags = {
      "Name" = "${var.environment}-nat-eip"
    }
  
  lifecycle {
    create_before_destroy = false
  }
}

resource "aws_route_table" "rt-private" {
  count = local.private_subnet_count
  vpc_id   = aws_vpc.devops.id
  
  tags = {
    Name        = format("%s-%s", "subnet", element(local.availability_zones, count.index))
  }
}

resource "aws_route_table_association" "private-rt-association" {
  count = local.private_subnet_count
  subnet_id      = element(aws_subnet.devops-private.*.id, count.index)
  route_table_id = element(aws_route_table.rt-private.*.id, count.index)
}

resource "aws_route" "private-route" {
  count                  = local.private_subnet_count
  route_table_id         = element(aws_route_table.rt-private.*.id, count.index)
  nat_gateway_id         = aws_nat_gateway.devops-nat.id
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = [aws_route_table.rt-private]
}
