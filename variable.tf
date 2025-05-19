variable "email_address" {
  description = "Email of the subscriber"
  type        = string
  default     = "gouthamr@hcltech.com"
}

variable "cloudtrail_role_name" {
  type        = string
  default     = "CloudTrail_CloudWatch_SNS_Role"
}
