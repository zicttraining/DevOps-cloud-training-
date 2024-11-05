
output "vpc1_private_ip" {
  value = aws_instance.web_1.private_ip
}

output "vpc2_private_ip" {
  value = aws_instance.web_2.private_ip
}

output "vpc1_route_table" {
  value = aws_route_table.route_table_1.id
}

output "vpc2_route_table" {
  value = aws_route_table.route_table_2.id
}