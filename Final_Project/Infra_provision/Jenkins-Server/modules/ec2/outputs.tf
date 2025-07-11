#modules/network-layer/variables.tf
# VPC
output "ec2_id_jenkins" {
  value = "${aws_instance.ec2_jenkins.id}"
}

# Subnet
output "ec2_public_ip" {
  value = "${aws_instance.ec2_jenkins.public_ip}"
}
