resource "aws_security_group" "devops-sg" {
  vpc_id = var.vpc_id
  name = var.name
}



resource "aws_security_group_rule" "allow-ingress-rule" {
  type              = "ingress"
  from_port         = var.from_port
  to_port           = var.to_port
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_blocks]
  security_group_id = aws_security_group.devops-sg.id
}

resource "aws_security_group_rule" "allow-egress-rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.devops-sg.id
}