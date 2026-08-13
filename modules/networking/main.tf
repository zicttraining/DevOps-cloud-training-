resource "aws_lb" "this" {
  name               = substr("${var.name_prefix}-alb", 0, 32)
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group_id]
  subnets            = var.public_subnet_ids
  tags               = merge(var.tags, { Name = "${var.name_prefix}-alb" })
}

resource "aws_lb_target_group" "web" {
  name     = substr("${var.name_prefix}-web-tg", 0, 32)
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path    = "/"
    matcher = "200-399"
  }
  tags = merge(var.tags, { Name = "${var.name_prefix}-web-tg" })
}

resource "aws_lb_target_group_attachment" "web" {
  for_each         = var.web_instance_ids
  target_group_arn = aws_lb_target_group.web.arn
  target_id        = each.value
  port             = 80
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

data "aws_route53_zone" "this" {
  count        = var.domain_name == null ? 0 : 1
  name         = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "this" {
  count   = var.domain_name == null ? 0 : 1
  zone_id = data.aws_route53_zone.this[0].zone_id
  name    = var.domain_name
  type    = "A"
  alias {
    name                   = aws_lb.this.dns_name
    zone_id                = aws_lb.this.zone_id
    evaluate_target_health = true
  }
}
