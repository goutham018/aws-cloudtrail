resource "aws_cloudwatch_log_metric_filter" "cloud-watch-filter" {
  name           = "console-login-for-demo"
  log_group_name = var.log_group_name
  pattern        = "{ $.eventName = \"ConsoleLogin\" }"

  metric_transformation {
    name      = "ConsoleLogin-for-demo"
    namespace = "CloudTrailMetrics"
    value     = "1"
  }
}
