resource "aws_sns_topic" "alarms" {
  name = "${var.name_prefix}-alarms"
  tags = var.tags
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alarms.arn
  protocol  = "email"
  endpoint  = var.notification_email
}

resource "aws_cloudwatch_log_group" "application" {
  name              = "/aws/${var.name_prefix}/application"
  retention_in_days = var.log_retention_days
  tags              = var.tags
}

resource "aws_cloudwatch_metric_alarm" "web_cpu" {
  for_each            = var.web_instance_ids
  alarm_name          = "${var.name_prefix}-web-${each.key}-cpu-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = var.cpu_threshold
  dimensions          = { InstanceId = each.value }
  alarm_actions       = [aws_sns_topic.alarms.arn]
}

resource "aws_cloudwatch_metric_alarm" "database_cpu" {
  alarm_name          = "${var.name_prefix}-database-cpu-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = var.cpu_threshold
  dimensions          = { DBInstanceIdentifier = var.database_instance_id }
  alarm_actions       = [aws_sns_topic.alarms.arn]
}
