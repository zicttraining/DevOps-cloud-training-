locals {
  user_data = <<-EOF
    #!/bin/bash
    set -e
    yum update -y
    yum install -y httpd
    systemctl enable --now httpd
    echo "<html><body><h1>${var.name_prefix} ${var.tier} server</h1></body></html>" > /var/www/html/index.html
  EOF
}

resource "aws_instance" "this" {
  for_each               = { for index, subnet_id in var.subnet_ids : tostring(index + 1) => subnet_id }
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = each.value
  vpc_security_group_ids = var.security_group_ids
  user_data              = local.user_data
  tags                   = merge(var.tags, { Name = "${var.name_prefix}-${var.tier}-${each.key}", Tier = var.tier })
}
