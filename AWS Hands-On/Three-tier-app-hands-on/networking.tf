# ACM Certificate for HTTPS with domain bmeevent.com
# resource "aws_acm_certificate" "bme_uat_app_cert" {
#   domain_name       = "bmeevent.com"
#   validation_method = "DNS"
#   tags = { Name = "bme-uat-app-cert" }
# }

# Route 53 Record for DNS-based certificate validation
# resource "aws_route53_record" "cert_validation" {
#   for_each = {
#     for dvo in aws_acm_certificate.bme_uat_app_cert.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       type   = dvo.resource_record_type
#       record = dvo.resource_record_value
#     }
#   }
#   zone_id = aws_route53_zone.bmeevent_zone.zone_id
#   name    = each.value.name
#   type    = each.value.type
#   records = [each.value.record]
#   ttl     = 60
# }

# Validates the ACM certificate using the DNS records
# resource "aws_acm_certificate_validation" "bme_uat_app_cert_validation" {
#   certificate_arn         = aws_acm_certificate.bme_uat_app_cert.arn
#   validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
# }

# Hosted Zone for bmeevent.com domain
resource "aws_route53_zone" "bmeevent_zone" {
  name = "bmeevent.com"
}

# Public EC2 Instance in a Public Subnet
resource "aws_instance" "bme_uat_app" {
  ami                         = "ami-xxxxxxx" # Replace with a valid AMI ID
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_subnet_1.id
  security_groups             = [aws_security_group.vpc_web_sg.id] # Ensure this security group is declared
  associate_public_ip_address = true

  tags = { Name = "bme-uat-app-server" }
}

# Load Balancer for HTTP and HTTPS traffic
resource "aws_lb" "bme_uat_app_lb" {
  name               = "bme-uat-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.vpc_web_sg.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  tags = { Name = "bme-uat-app-lb" }
}

# Target Group pointing to the EC2 instance
resource "aws_lb_target_group" "bme_uat_app_tg" {
  name       = "bme-uat-app-tg"
  port       = 80
  protocol   = "HTTP"
  vpc_id     = aws_vpc.bme_uat_app.id
  target_type = "instance"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
  }

  tags = { Name = "bme-uat-app-tg" }
}

# Register the EC2 instance with the Target Group
resource "aws_lb_target_group_attachment" "bme_uat_app_tg_attachment" {
  target_group_arn = aws_lb_target_group.bme_uat_app_tg.arn
  target_id        = aws_instance.bme_uat_app.id
  port             = 80
}

# HTTP Listener redirects traffic to HTTPS
resource "aws_lb_listener" "bme_uat_app_http_listener" {
  load_balancer_arn = aws_lb.bme_uat_app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      protocol    = "HTTPS"
      port        = "443"
      status_code = "HTTP_301"
    }
  }
}

# HTTPS Listener for secure traffic with ACM certificate
# resource "aws_lb_listener" "bme_uat_app_https_listener" {
#   load_balancer_arn = aws_lb.bme_uat_app_lb.arn
#   port              = 443
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = aws_acm_certificate.bme_uat_app_cert.arn

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.bme_uat_app_tg.arn
#   }
# }

# Route 53 A Record to point domain to Load Balancer
resource "aws_route53_record" "bme_uat_app_record" {
  zone_id = aws_route53_zone.bmeevent_zone.zone_id
  name    = "bmeevent.com"
  type    = "A"
  alias {
    name                   = aws_lb.bme_uat_app_lb.dns_name
    zone_id                = aws_lb.bme_uat_app_lb.zone_id
    evaluate_target_health = true
  }
}
