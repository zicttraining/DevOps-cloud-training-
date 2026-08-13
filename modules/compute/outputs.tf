output "instance_ids" { value = { for key, instance in aws_instance.this : key => instance.id } }
output "public_ips" { value = [for instance in aws_instance.this : instance.public_ip] }
output "private_ips" { value = [for instance in aws_instance.this : instance.private_ip] }
