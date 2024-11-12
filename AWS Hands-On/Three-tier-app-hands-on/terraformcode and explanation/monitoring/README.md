Explanation for README
SNS Topic and Subscription:

bme-uat-app_alarm_topic: Creates an SNS topic to send alarm notifications.
bme-uat-app_email_subscription: Subscribes an email address (samuel.ogah@zicloudtech.com, which can be customized) to receive notifications when alarms are triggered.

CloudWatch Log Group:

bme-uat-app_logs: Defines a log group to store application logs in CloudWatch for 7 days. Adjust the retention period as needed.

CloudTrail:

bme-uat-app_trail: Creates a CloudTrail for auditing and tracking API calls, logging to a specified S3 bucket. Replace bme-uat-app_bucket with an actual S3 bucket name in your configuration.

CloudWatch Alarms:

EC2 CPU Alarm: Monitors the CPU utilization of the EC2 instance and triggers an alarm if CPU usage exceeds 85% for two consecutive 5-minute periods (evaluation period of 10 minutes).
RDS CPU Alarm: Monitors the CPU utilization of the RDS instance and triggers an alarm under the same conditions as the EC2 CPU alarm.
Notification Actions: Both alarms use the SNS topic (bme-uat-app_alarm_topic) to send alerts when triggered.

Customizations:

Email Subscription: Replace samuel.ogah@zicloudtech.com with the desired notification email address.

Log Retention Period: Modify retention_in_days in bme-uat-app_logs to retain logs for a different period if required.
CloudTrail S3 Bucket: Ensure bme-uat-app_bucket is set up as an S3 bucket and update the reference if necessary.

This configuration provides essential monitoring for CPU usage on EC2 and RDS instances, logs application activity, and enables notification alerts to proactively manage resource performance.