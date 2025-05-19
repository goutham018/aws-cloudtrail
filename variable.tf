variable "email_address" {
  description = "Email of the subscriber"
  type        = string
}

variable "cloudtrail_role_name" {
  type        = string
  default     = "CloudTrail_CloudWatch_SNS_Role"
}
