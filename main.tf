module "sns" {
  source        = "./modules/sns_alerts"
  email_address = var.email_address
}

module "iam_role" {
  source        = "./modules/iam-role"
  role_name     = var.cloudtrail_role_name
  sns_topic_arn = module.sns.topic_arn
}

module "cloudtrail" {
  source              = "./modules/cloudtrail"
  cloudtrail_role_arn = module.iam_role.role_arn
  sns_topic_arn       = module.sns.topic_arn
}
