# SNS Topic for sending alarm notifications
resource "aws_sns_topic" "bme-uat-app_alarm_topic" {
  name = "bme-uat-app-cpu-usage-alarm-topic"
}

# SNS Subscription to receive email notifications
resource "aws_sns_topic_subscription" "bme-uat-app_email_subscription" {
  topic_arn = aws_sns_topic.bme-uat-app_alarm_topic.arn
  protocol  = "email"
  endpoint  = "samuel.ogah@zicloudtech.com" # Replace with the desired email address
}

# CloudWatch Log Group for application logs
resource "aws_cloudwatch_log_group" "bme-uat-app_logs" {
  name              = "/aws/bme-uat-app/logs"
  retention_in_days = 7 # Retain logs for 7 days
}

# CloudTrail for tracking API calls and activity logs
resource "aws_cloudtrail" "bme-uat-app_trail" {
  name           = "bme-uat-app-trail"
  s3_bucket_name = aws_s3_bucket.bme-uat-app_bucket.bucket # Replace with actual S3 bucket for CloudTrail logs
}

# CloudWatch Alarm for EC2 instance CPU usage exceeding 85%
resource "aws_cloudwatch_metric_alarm" "bme-uat-app_ec2_cpu_alarm" {
  alarm_name          = "bme-uat-app-ec2-cpu-usage-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 85 # Trigger alarm if CPU usage exceeds 85%
  dimensions = {
    InstanceId = aws_instance.bme-uat-app.id
  }

  alarm_actions = [aws_sns_topic.bme-uat-app_alarm_topic.arn]
}

# CloudWatch Alarm for RDS instance CPU usage exceeding 85%
resource "aws_cloudwatch_metric_alarm" "bme-uat-app_rds_cpu_alarm" {
  alarm_name          = "bme-uat-app-rds-cpu-usage-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 85 # Trigger alarm if CPU usage exceeds 85%
  dimensions = {
    DBInstanceIdentifier = aws_db_instance.bme-uat-app_db.id
  }

  alarm_actions = [aws_sns_topic.bme-uat-app_alarm_topic.arn]
}
