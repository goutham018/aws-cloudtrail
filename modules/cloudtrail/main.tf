resource "aws_s3_bucket" "trail_bucket" {
  bucket        = "cloudtrail-activity-logs-273550"
  force_destroy = true

  tags = {
    Name = "CloudTrail-Bucket-for-demo"
  }
}

resource "aws_s3_bucket_policy" "trail_bucket_policy" {
  bucket = aws_s3_bucket.trail_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action   = "s3:GetBucketAcl"
        Resource = aws_s3_bucket.trail_bucket.arn
      },
      {
        Effect    = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action = "s3:PutObject"
        Resource = "${aws_s3_bucket.trail_bucket.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}

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
  name                          = "account-activity-trail"
  s3_bucket_name                = aws_s3_bucket.trail_bucket.bucket
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  enable_logging                = true
  cloud_watch_logs_role_arn     = aws_iam_role.cloudtrail_role.arn
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.trail-for-demo.arn}:*"

  depends_on = [
    aws_iam_role_policy.cloudtrail_policy,
    aws_s3_bucket_policy.trail_bucket_policy,
    aws_cloudwatch_log_group.trail-for-demo
  ]
}

output "log_group_name" {
  value = aws_cloudwatch_log_group.trail-for-demo.name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.trail_bucket.bucket
}
