| AWS Service               | Terraform Reference                    | Example Resource                                                    |
|---------------------------|----------------------------------------|---------------------------------------------------------------------|
| Amazon S3                 | `aws_s3_bucket`                        | `resource "aws_s3_bucket" "example" { ... }`                        |
| Amazon EC2                | `aws_instance`                         | `resource "aws_instance" "example" { ... }`                         |
| Amazon RDS                | `aws_db_instance`                      | `resource "aws_db_instance" "example" { ... }`                      |
| Amazon VPC                | `aws_vpc`                              | `resource "aws_vpc" "example" { ... }`                              |
| AWS Lambda                | `aws_lambda_function`                  | `resource "aws_lambda_function" "example" { ... }`                  |
| Amazon DynamoDB           | `aws_dynamodb_table`                   | `resource "aws_dynamodb_table" "example" { ... }`                   |
| Amazon CloudWatch         | `aws_cloudwatch_log_group`             | `resource "aws_cloudwatch_log_group" "example" { ... }`             |
| Amazon SNS                | `aws_sns_topic`                        | `resource "aws_sns_topic" "example" { ... }`                        |
| Amazon SQS                | `aws_sqs_queue`                        | `resource "aws_sqs_queue" "example" { ... }`                        |
| AWS IAM Role              | `aws_iam_role`                         | `resource "aws_iam_role" "example" { ... }`                         |
| AWS IAM Policy            | `aws_iam_policy`                       | `resource "aws_iam_policy" "example" { ... }`                       |
| AWS Security Group        | `aws_security_group`                   | `resource "aws_security_group" "example" { ... }`                   |
| Amazon ElastiCache        | `aws_elasticache_cluster`              | `resource "aws_elasticache_cluster" "example" { ... }`              |
| Amazon EBS                | `aws_ebs_volume`                       | `resource "aws_ebs_volume" "example" { ... }`                       |
| Elastic Load Balancer     | `aws_lb`                               | `resource "aws_lb" "example" { ... }`                               |
| Amazon Route 53           | `aws_route53_zone`                     | `resource "aws_route53_zone" "example" { ... }`                     |
| Amazon CloudFront         | `aws_cloudfront_distribution`          | `resource "aws_cloudfront_distribution" "example" { ... }`          |
| AWS EKS Cluster           | `aws_eks_cluster`                      | `resource "aws_eks_cluster" "example" { ... }`                      |
| AWS ECS Cluster           | `aws_ecs_cluster`                      | `resource "aws_ecs_cluster" "example" { ... }`                      |
| AWS CodePipeline          | `aws_codepipeline`                     | `resource "aws_codepipeline" "example" { ... }`                     |
| AWS CodeBuild             | `aws_codebuild_project`                | `resource "aws_codebuild_project" "example" { ... }`                |
| Amazon EMR Cluster        | `aws_emr_cluster`                      | `resource "aws_emr_cluster" "example" { ... }`                      |
| Amazon EMR Instance Group | `aws_emr_instance_group`               | `resource "aws_emr_instance_group" "example" { ... }`               |
| Amazon Redshift Cluster   | `aws_redshift_cluster`                 | `resource "aws_redshift_cluster" "example" { ... }`                 |
| Amazon Kinesis Stream     | `aws_kinesis_stream`                   | `resource "aws_kinesis_stream" "example" { ... }`                   |
| Amazon Kinesis Firehose   | `aws_kinesis_firehose_delivery_stream` | `resource "aws_kinesis_firehose_delivery_stream" "example" { ... }` |
| AWS Glue Catalog Database | `aws_glue_catalog_database`            | `resource "aws_glue_catalog_database" "example" { ... }`            |
| AWS Glue Job              | `aws_glue_job`                         | `resource "aws_glue_job" "example" { ... }`                         |
| Amazon Athena Workgroup   | `aws_athena_workgroup`                 | `resource "aws_athena_workgroup" "example" { ... }`                 |
| AWS DataSync              | `aws_datasync_task`                    | `resource "aws_datasync_task" "example" { ... }`                    |
| Amazon OpenSearch         | `aws_opensearch_domain`                | `resource "aws_opensearch_domain" "example" { ... }`                |