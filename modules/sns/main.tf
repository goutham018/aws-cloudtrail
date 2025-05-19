resource "aws_sns_topic" "login_alerts" {
  name = "subscriber-alerts"
}

resource "aws_sns_topic_subscription" "subscriber_email" {
  topic_arn = aws_sns_topic.login_alerts.arn
  protocol  = "email"
  endpoint  = var.email
}

output "topic_arn" {
  value = aws_sns_topic.login_alerts.arn
}
