# SNS Topic for sending alarm notifications
resource "aws_sns_topic" "bme_uat_app_alarm_topic" {
  name = "bme-uat-app-cpu-usage-alarm-topic"
}

# SNS Subscription to receive email notifications
resource "aws_sns_topic_subscription" "bme_uat_app_email_subscription" {
  topic_arn = aws_sns_topic.bme_uat_app_alarm_topic.arn
  protocol  = "email"
  endpoint  = "samuel.ogah@zicloudtech.com" # Replace with the desired email address
}

# CloudWatch Log Group for application logs
resource "aws_cloudwatch_log_group" "bme_uat_app_logs" {
  name              = "/aws/bme-uat-app/logs"
  retention_in_days = 7 # Retain logs for 7 days
}

# S3 Bucket for CloudTrail logs
resource "aws_s3_bucket" "bme_uat_app_bucket" {
  bucket = "bmedevapp"  # Set to the specified bucket name

  tags = {
    Name        = "bme_uat_app_bucket"
    Environment = "Production"
  }
}

# CloudTrail for tracking API calls and activity logs
resource "aws_cloudtrail" "bme_uat_app_trail" {
  name           = "bme-uat-app-trail"
  s3_bucket_name = aws_s3_bucket.bme_uat_app_bucket.bucket # Reference to the declared S3 bucket
}

# CloudWatch Alarm for EC2 instance CPU usage exceeding 85%
resource "aws_cloudwatch_metric_alarm" "bme_uat_app_ec2_cpu_alarm" {
  alarm_name          = "bme-uat-app-ec2-cpu-usage-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 85 # Trigger alarm if CPU usage exceeds 85%
  dimensions = {
    InstanceId = aws_instance.bme_uat_web_1.id # Update to a valid EC2 instance
  }

  alarm_actions = [aws_sns_topic.bme_uat_app_alarm_topic.arn]  # Ensure this reference is complete
}

# CloudWatch Alarm for RDS instance CPU usage exceeding 85%
resource "aws_cloudwatch_metric_alarm" "bme_uat_app_rds_cpu_alarm" {
  alarm_name          = "bme-uat-app-rds-cpu-usage-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 85 # Trigger alarm if CPU usage exceeds 85%
  dimensions = {
    DBInstanceIdentifier = aws_db_instance.bme_uat_app_db.id # Ensure this RDS instance is declared
  }

  alarm_actions = [aws_sns_topic.bme_uat_app_alarm_topic.arn]  # Ensure this reference is complete
}

