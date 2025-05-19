terraform {
  required_version = ">= 1.1.0"
  backend "s3" {
    bucket  = "my-aws-bucket-273550"
    key     = "goutham/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}