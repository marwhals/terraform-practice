variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}

variable "acl" {
  type        = string
  default     = "private"
  description = "The canned ACL to apply"
}

variable "environment" {
  type        = string
  description = "Environment name"
}
