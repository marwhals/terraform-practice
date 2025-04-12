provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "example" {
  bucket = "my-bucket-${terraform.workspace}"
  tags = {
    Environment = terraform.workspace
  }
}