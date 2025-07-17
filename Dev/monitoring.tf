# SNS Topic for sending alarm notifications
resource "aws_sns_topic" "bs101-dev_alarm_topic" {
  name = "bs101-dev-app-cpu-usage-alarm-topic"
}

# SNS Subscription to receive email notifications
resource "aws_sns_topic_subscription" "bs101-dev_email_subscription" {
  topic_arn = aws_sns_topic.bs101-dev_alarm_topic.arn
  protocol  = "email"
  endpoint  = "samuel.ogah@zicloudtech.com" # Replace with the desired email address
}

# CloudWatch Log Group for application logs
resource "aws_cloudwatch_log_group" "bs101-dev_logs" {
  name              = "/aws/bs101-dev-app/logs"
  retention_in_days = 7 # Retain logs for 7 days
}

# Random ID for unique S3 bucket name suffix
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# S3 Bucket for CloudTrail logs with unique name
resource "aws_s3_bucket" "bs101-dev_monitoring_bucket" {
  bucket = "bs101-dev-app-monitoring-${random_id.bucket_suffix.hex}"

  tags = {
    Name        = "bs101-dev_monitoring_bucket"
    Environment = "dev"
  }
}

# Policy for CloudTrail to write logs to the S3 bucket
resource "aws_s3_bucket_policy" "bs101-dev_monitoring_bucket_policy" {
  bucket = aws_s3_bucket.bs101-dev_monitoring_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowCloudTrailWrite",
        Effect = "Allow",
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        },
        Action   = "s3:PutObject",
        Resource = "${aws_s3_bucket.bs101-dev_monitoring_bucket.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      },
      {
        Sid    = "AllowCloudTrailBucketAccess",
        Effect = "Allow",
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        },
        Action   = "s3:GetBucketAcl",
        Resource = aws_s3_bucket.bs101-dev_monitoring_bucket.arn
      }
    ]
  })
}

# CloudTrail for tracking API calls and activity logs
resource "aws_cloudtrail" "bs101-dev_trail" {
  name                       = "bs101-dev-app-trail2"
  s3_bucket_name             = aws_s3_bucket.bs101-dev_monitoring_bucket.bucket
  is_multi_region_trail      = false
  enable_log_file_validation = true

  tags = {
    Name = "bs101-dev-app-cloudtrail"
  }
}

# IAM Role for CloudWatch Alarms to send notifications to SNS
resource "aws_iam_role" "cloudwatch_alarm_role" {
  name = "bs101-dev-app-cloudwatch-alarm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "cloudwatch.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# IAM Policy for CloudWatch Alarms to publish to SNS topic
resource "aws_iam_policy" "cloudwatch_alarm_policy" {
  name        = "bs101-dev-app-cloudwatch-alarm-policy"
  description = "Allows CloudWatch Alarms to publish to SNS"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "sns:Publish"
        ],
        Resource = aws_sns_topic.bs101-dev_alarm_topic.arn
      }
    ]
  })
}

# Attach the CloudWatch Alarm Policy to the Role
resource "aws_iam_role_policy_attachment" "cloudwatch_alarm_role_attachment" {
  role       = aws_iam_role.cloudwatch_alarm_role.name
  policy_arn = aws_iam_policy.cloudwatch_alarm_policy.arn
}

# CloudWatch Alarm for EC2 instance CPU usage exceeding 85%
resource "aws_cloudwatch_metric_alarm" "bs101-dev_ec2_cpu_alarm" {
  alarm_name          = "bs101-dev-app-ec2-cpu-usage-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 85
  dimensions = {
    InstanceId = aws_instance.bs101_dev_web_1.id # Make sure this EC2 instance is defined in the configuration
  }

  alarm_actions = [aws_sns_topic.bs101-dev_alarm_topic.arn]
}

# CloudWatch Alarm for RDS instance CPU usage exceeding 85%
resource "aws_cloudwatch_metric_alarm" "bs101-dev_rds_cpu_alarm" {
  alarm_name          = "bs101-dev-app-rds-cpu-usage-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 85
  dimensions = {
    DBInstanceIdentifier = aws_db_instance.bs101-dev_db.id # Ensure this RDS instance is defined in the configuration
  }

  alarm_actions = [aws_sns_topic.bs101-dev_alarm_topic.arn]
}

# Caller identity to get the current AWS account ID for IAM role references
data "aws_caller_identity" "current" {}
