module "sns" {
  source      = "./modules/sns"
  email       = var.email_address
}

module "cloudtrail" {
  source = "./modules/cloudtrail"
}

module "cloudwatch" {
  source            = "./modules/cloudwatch"
  log_group_name    = module.cloudtrail.log_group_name
}

module "alarm-trigger" {
  source            = "./modules/alarm-trigger"
  log_group_name    = module.cloudtrail.log_group_name
  filter_pattern    = "{ $.eventName = \"ConsoleLogin\" }"
  sns_topic_arn     = module.sns.topic_arn
}
