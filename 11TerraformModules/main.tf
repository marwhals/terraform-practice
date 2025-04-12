provider "aws" {
  region = "us-east-1"
}

module "s3_main" {
  source      = "./modules/s3_bucket"
  bucket_name = "my-app-bucket-123"
  acl         = "private"
  environment = "dev"
}
