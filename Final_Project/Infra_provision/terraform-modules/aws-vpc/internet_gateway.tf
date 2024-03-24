resource "aws_internet_gateway" "devops-ig" {
  vpc_id = aws_vpc.devops.id

  tags = {
    Name = "${var.environment}-ig"
  }
}