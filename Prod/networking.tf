resource "aws_instance" "bs101_prod" {
  ami                         = "ami-066a7fbea5161f451"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_subnet_1.id
  vpc_security_group_ids      = [aws_security_group.vpc_web_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "bs101-prod-app-server"
  }
}

resource "aws_lb" "bs101_prod_lb" {
  name               = "bs101-prod-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.vpc_web_sg.id]
  subnets = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]

  tags = {
    Name = "bs101-prod-app-lb"
  }
}

resource "aws_lb_target_group" "bs101_prod_tg" {
  name        = "bs101-prod-app-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.bs101-prod.id
  target_type = "instance"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
  }

  tags = {
    Name = "bs101-prod-app-tg"
  }
}

resource "aws_lb_target_group_attachment" "bs101_prod_tg_attachment" {
  target_group_arn = aws_lb_target_group.bs101_prod_tg.arn
  target_id        = aws_instance.bs101_prod.id
  port             = 80
}

resource "aws_lb_listener" "bs101_prod_http_listener" {
  load_balancer_arn = aws_lb.bs101_prod_lb.arn
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

resource "aws_route53_zone" "bs101event_zone" {
  name = "bs101event.com"
}

resource "aws_route53_record" "bs101_prod_record" {
  zone_id = aws_route53_zone.bs101event_zone.zone_id
  name    = "bs101event.com"
  type    = "A"

  alias {
    name                   = aws_lb.bs101_prod_lb.dns_name
    zone_id                = aws_lb.bs101_prod_lb.zone_id
    evaluate_target_health = true
  }
}
