output "vpc_attributes" {
    value = aws_vpc.devops
}

output "private_subnet_id" {
    value = aws_subnet.devops-private.*.id
}