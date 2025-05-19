resource "aws_cloudwatch_metric_alarm" "cloud-watch-alarm" {
  alarm_name          = "Login-Alert"
  alarm_description   = "Login Alert Alaram"
  metric_name         = "ConsoleLogin-for-demo"
  namespace           = "CloudTrailMetrics"
  statistic           = "Sum"
  period              = 300
  evaluation_periods  = 1
  threshold           = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"
  alarm_actions       = [var.sns_topic_arn]
}
