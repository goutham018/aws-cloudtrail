
data "aws_caller_identity" "current" {}

resource "aws_cloudwatch_log_group" "trail-for-demo" {
  name              = "/aws/cloudtrail/login/demo"
  retention_in_days = 30
}

resource "aws_iam_role" "cloudtrail_role" {
  name = "cloudtrail-role-for-demo"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "cloudtrail.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "cloudtrail_policy" {
  name = "cloudwatch-policy-for-demo"
  role = aws_iam_role.cloudtrail_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "logs:PutLogEvents",
        "logs:CreateLogStream"
      ]
      Resource = "${aws_cloudwatch_log_group.trail-for-demo.arn}:*"
    }]
  })
}

resource "aws_cloudtrail" "trail" {
  name                          = "activity-trail-for-demo"
  s3_bucket_name                = aws_s3_bucket.trail_bucket.bucket
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  enable_logging                = true
  cloud_watch_logs_role_arn     = aws_iam_role.cloudtrail_role.arn
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.trail-for-demo.arn}:*"

  depends_on = [
    aws_iam_role_policy.cloudtrail_policy,
    aws_cloudwatch_log_group.trail-for-demo
  ]
}