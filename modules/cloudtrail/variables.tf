variable "cloudtrail_role_arn" {
  type = string
}

variable "sns_topic_arn" {
  type = string
}

variable "cloudtrail_name" {
  description = "Name of the CloudTrail trail"
  type        = string
}

variable "log_group_name" {
  description = "Name of the CloudWatch Logs group"
  type        = string
}
