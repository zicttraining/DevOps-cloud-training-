# AWS Budget to monitor monthly spending for EC2
resource "aws_budgets_budget" "bme-uat-app_budget" {
  name         = "bme-uat-app-budget"           # Budget name
  budget_type  = "COST"                         # Track actual costs
  limit_amount = "100"                          # Budget limit in USD
  limit_unit   = "USD"
  time_unit    = "MONTHLY"                      # Reset budget monthly

  # Filter budget to track only EC2 service costs
  cost_filters = {
    Service = "AmazonEC2"
  }

  # Notification configuration to alert when costs exceed 80%
  notifications {
    comparison_operator = "GREATER_THAN"
    notification_type   = "ACTUAL"
    threshold           = 80                   # Alert at 80% of budget
    threshold_type      = "PERCENTAGE"
  }
}

