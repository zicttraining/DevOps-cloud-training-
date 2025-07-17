# ACM Certificate for HTTPS with domain bs101event.com
# Uncomment the following block and ensure ACM certificate validation is set up correctly if you want to use HTTPS.

# resource "aws_acm_certificate" "bs101-dev_cert" {
#   domain_name       = "bs101event.com"
#   validation_method = "DNS"
#   tags = { Name = "bs101-dev-app-cert" }
# }

# Route 53 Record for DNS-based certificate validation
# Uncomment if you need certificate validation.
# resource "aws_route53_record" "cert_validation" {
#   for_each = {
#     for dvo in aws_acm_certificate.bs101-dev_cert.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       type   = dvo.resource_record_type
#       record = dvo.resource_record_value
#     }
#   }
#   zone_id = aws_route53_zone.bs101event_zone.zone_id
#   name    = each.value.name
#   type    = each.value.type
#   records = [each.value.record]
#   ttl     = 60
# }

# Validate ACM Certificate using DNS
# Uncomment if using HTTPS with DNS validation for ACM.
# resource "aws_acm_certificate_validation" "bs101-dev_cert_validation" {
#   certificate_arn         = aws_acm_certificate.bs101-dev_cert.arn
#   validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
# }

# Hosted Zone for the domain bs101event.com
resource "aws_route53_zone" "bs101event_zone" {
  name = "bs101event.com"
}

# Public EC2 Instance in a Public Subnet
resource "aws_instance" "bs101-dev" {
  ami                         = "ami-066a7fbea5161f451" # Replace with a valid AMI ID
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_subnet_1.id
  security_groups             = [aws_security_group.vpc_web_sg.id] # Ensure this security group is declared
  associate_public_ip_address = true

  tags = { Name = "bs101-dev-app-server" }
}

# Load Balancer for HTTP and HTTPS traffic
resource "aws_lb" "bs101-dev_lb" {
  name               = "bs101-dev-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.vpc_web_sg.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  tags = { Name = "bs101-dev-app-lb" }
}

# Target Group pointing to the EC2 instance
resource "aws_lb_target_group" "bs101-dev_tg" {
  name        = "bs101-dev-app-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.bs101-dev.id
  target_type = "instance"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
  }

  tags = { Name = "bs101-dev-app-tg" }
}

# Register the EC2 instance with the Target Group
resource "aws_lb_target_group_attachment" "bs101-dev_tg_attachment" {
  target_group_arn = aws_lb_target_group.bs101-dev_tg.arn
  target_id        = aws_instance.bs101-dev.id
  port             = 80
}

# HTTP Listener to redirect traffic to HTTPS
resource "aws_lb_listener" "bs101-dev_http_listener" {
  load_balancer_arn = aws_lb.bs101-dev_lb.arn
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
# Uncomment if you are using HTTPS and have a validated ACM certificate.
# resource "aws_lb_listener" "bs101-dev_https_listener" {
#   load_balancer_arn = aws_lb.bs101-dev_lb.arn
#   port              = 443
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = aws_acm_certificate.bs101-dev_cert.arn
#
#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.bs101-dev_tg.arn
#   }
# }

# Route 53 A Record to point domain to Load Balancer
resource "aws_route53_record" "bs101-dev_record" {
  zone_id = aws_route53_zone.bs101event_zone.zone_id
  name    = "bs101event.com"
  type    = "A"
  alias {
    name                   = aws_lb.bs101-dev_lb.dns_name
    zone_id                = aws_lb.bs101-dev_lb.zone_id
    evaluate_target_health = true
  }
}

