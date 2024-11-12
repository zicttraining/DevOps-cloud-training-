# ACM Certificate for HTTPS with domain bemeevent.com
resource "aws_acm_certificate" "bme_uat_app_cert" {
  domain_name       = "bmeevent.com" # Domain for SSL certificate
  validation_method = "DNS"

  tags = {
    Name = "bme-uat-app-cert"
  }
}

# Route 53 Record for DNS-based certificate validation
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.bme_uat_app_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }
  zone_id = aws_route53_zone.bmeevent_zone.zone_id # Replace with hosted zone ID
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}

# Validates the ACM certificate using the DNS records
resource "aws_acm_certificate_validation" "bme_uat_app_cert_validation" {
  certificate_arn         = aws_acm_certificate.bme_uat_app_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

# Hosted Zone for bemeevent.com domain
resource "aws_route53_zone" "bmeevent_zone" {
  name = "bmeevent.com" # Domain hosted zone
}

# Application Load Balancer with HTTP and HTTPS listeners
resource "aws_lb" "bme_uat_app_lb" {
  name               = "bme-uat-app-lb"       # Load Balancer name
  internal           = false                  # Public-facing load balancer
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = [aws_subnet.public_subnet.id]

  tags = {
    Name = "bme-uat-app-lb"
  }
}

# Target Group for routing traffic from Load Balancer
resource "aws_lb_target_group" "bme_uat_app_tg" {
  name     = "bme-uat-app-tg" # Target group name
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id

  tags = {
    Name = "bme-uat-app-tg"
  }
}

# HTTP Listener redirects traffic to HTTPS
resource "aws_lb_listener" "bme_uat_app_http_listener" {
  load_balancer_arn = aws_lb.bme_uat_app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "redirect"
    redirect {
      protocol = "HTTPS"
      port     = "443"
      status_code = "HTTP_301"
    }
  }
}

# HTTPS Listener for secure traffic with ACM certificate
resource "aws_lb_listener" "bme_uat_app_https_listener" {
  load_balancer_arn = aws_lb.bme_uat_app_lb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.bme_uat_app_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.bme_uat_app_tg.arn
  }
}

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

  tags = {
    Name = "bme-uat-app-record"
  }
}

