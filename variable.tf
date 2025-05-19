variable "email_address" {
  description = "Email to the subscriber"
  type        = string
  default     = "gouthamr@hcltech.com"
}

variable "cloudtrail_role_name" {
  description = "IAM role name for CloudTrail"
  type        = string
  default     = "cloudtrail_role_name"
}

variable "cloudtrail_name" {
  description = "Name of the CloudTrail trail"
  type        = string
  default     = "cloudtrail_name_logs"
}

variable "log_group_name" {
  description = "CloudWatch Logs group name"
  type        = string
  default     = "aws-log_group"
}
