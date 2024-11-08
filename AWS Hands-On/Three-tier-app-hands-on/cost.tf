# AWS Budget to monitor monthly spending for EC2
resource "aws_budgets_budget" "bme-uat-app_budget" {
  name          = "AppBudget"
  budget_type   = "COST"
  limit_amount  = "100"
  limit_unit    = "USD"
  time_unit     = "MONTHLY"

  cost_filter {
    name = "Service"
    values = ["AmazonEC2"]
  }

  notification {
    comparison_operator = "GREATER_THAN"
    notification_type   = "ACTUAL"
    threshold           = 80
    threshold_type      = "PERCENTAGE"
  }
}


