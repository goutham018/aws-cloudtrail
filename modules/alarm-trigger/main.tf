resource "aws_cloudwatch_metric_alarm" "cloud-watch-alarm" {
  alarm_name          = "AWS-Login-Alarm"
  alarm_description   = "Triggers on AWS Console login attempts"
  metric_name         = "ConsoleLogin-for-demo"
  namespace           = "CloudTrailMetrics"
  statistic           = "Sum"
  period              = 300
  evaluation_periods  = 1
  threshold           = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"
  alarm_actions       = [var.sns_topic_arn]
}
