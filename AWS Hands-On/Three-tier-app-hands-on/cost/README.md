Explanation for README

Resource Name and Type: This AWS budget resource, named bme-uat-app_budget, is configured to monitor actual monthly costs for the project’s EC2 services.

Budget Limit and Time Unit:

limit_amount is set to $100 USD, which serves as the monthly budget limit. You can adjust this based on project requirements.
time_unit is set to "MONTHLY", so the budget resets at the start of each month.

Cost Filter:

The cost_filters section restricts the budget to track only costs associated with the "AmazonEC2" service. Additional AWS services can be added by modifying this section.

Notifications:

A notification is configured to alert at 80% of the budget limit. When actual costs exceed 80% (i.e., $80 USD), an alert will be triggered.
comparison_operator as "GREATER_THAN" ensures the notification is sent when the cost surpasses the threshold.
notification_type as "ACTUAL" indicates that the alert is based on actual spending rather than forecasts.

Customizations:

To increase or decrease the budget threshold, adjust the threshold value (e.g., set to 90 for notifications at 90%).
To track additional services or configure additional notifications, modify cost_filters and add more notifications blocks as needed.
This configuration ensures that monthly spending is monitored, and alerts are sent when costs approach the budget limit, supporting proactive budget management for the project