# AWS and Terraform

### IAM - *AI generated table*

| Policy Type             | Description                                                           |
|-------------------------|-----------------------------------------------------------------------|
| AdministratorAccess     | Provides full access to AWS services and resources.                   |
| PowerUserAccess         | Full access to all services except managing IAM users and groups.     |
| AmazonS3FullAccess      | Grants full access to Amazon S3 buckets and objects.                  |
| AWSKeyManagementService | Permissions to create, manage, and use encryption keys in AWS KMS.    |
| Billing                 | Allows access to view and modify AWS billing and account information. |
| ReadOnlyAccess          | Grants read-only permissions across all AWS services.                 |
| AmazonS3ReadOnlyAccess  | Grants read-only permissions to Amazon S3 buckets and objects.        |

### Programmatic Access

- Use AWS CLI
  `aws iam create-user --user-name bob`

### AWS IAM Create-User Command Flags

| Flag                   | Description                                                               |
|------------------------|---------------------------------------------------------------------------|
| --user-name            | Specifies the name of the new IAM user.                                   |
| --permissions-boundary | Attaches a permissions boundary to the user to limit its maximum access.  |
| --tags                 | Adds metadata tags to the IAM user for identification and categorization. |
| --cli-input-json       | Provides the full command input as a JSON formatted string.               |
| --profile              | Specifies the named AWS CLI profile to use for the command.               |

## IAM with Terraform

```hcl
provider "aws" {
  region     = "us-west-2"
  access_key = "<YOUR_AWS_ACCESS_KEY>" ### This can be moved to the .aws/credentials file
  secret_key = "<YOUR_AWS_SECRET_KEY>"
}

resource "aws_iam_user" "admin-user" {
  name = "bob"
  tags = {
    Description = "Technical Team Leader"
  }
}
```

These variables can be exported using

- `export AWS_ACCESS_KEY_ID=ABCD123`
- `export AWS_SECRET_ACCESS_KEY_ID=jeasdoij242`
- `export AWS_REGION=us-west-2`

## IAM Policies with Terraform

```hcl
resource "aws_iam_user" "example_user" {
  name = "example-user"

  tags = {
    Description = "Technical Team Leader"
  }
}

resource "aws_iam_policy" "adminUser" {
  name   = "AdminUsers"
  policy = <<EOF
  EOF
}
```

```bash
[COMMAND] <<DELIMITER
  Line1
  Line2
  Line3
DELIMITER
```

## Complete example

```hcl

resource "aws_iam_user" "example_user" {
  name = "example-user"

  tags = {
    Description = "Example IAM User"
  }
}

resource "aws_iam_policy" "example_policy" {
  name        = "ExamplePolicy"
  description = "An example policy that provides specific permissions"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowS3FullAccess"
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "arn:aws:s3:::example-bucket",
          "arn:aws:s3:::example-bucket/*"
        ]
      },
      {
        Sid    = "AllowEC2ReadOnlyAccess"
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeVolumes",
          "ec2:DescribeSnapshots"
        ]
        Resource = "*"
      },
      {
        Sid    = "DenyIAMUserManagement"
        Effect = "Deny"
        Action = [
          "iam:CreateUser",
          "iam:DeleteUser",
          "iam:UpdateUser"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "example_user_policy_attachment" {
  user       = aws_iam_user.example_user.name
  policy_arn = aws_iam_policy.example_policy.arn
}
```

- can create a separate IAM policy document `admin-policy.json` and then load it in terraform using
  `policy = file(admin-policy.json)`

# Intro to AWS S3

## S3 with terraform

[//]: # (TODO fix the formatting in this )

```hcl
resource "aws_s3_bucket" "finance" {
  bucket = "finance-12345"
  tags = {
    Description = "Finance and Payroll"
  }
}

resource "aws_s3_bucket_object" "finance-2020" {
  content = "/root/finance/finance-2020.doc"
  content = "finance-2020.doc"
  bucket  = aws_s3_bucket.finance.id
}

data "aws_iam_group" "finance-data" {
  group_name = "finance-analysts"
}

resource "aws_s3_bucket_policy" "finance-policy" {
  bucket = aws_s3_bucket.finance.id
  policy = <<EOF
  {
    "Version": "2021-19-17",
    "Statement": [
      {
        "Action": "*",
        "Effect": "Allow",
        "Resource": "arn:aws:s3:::${aws_s3_bucket.finance.id}/*",
        "Principal": {
        "AWS": [
          "${data.aws_iam_group.finance-data.arn}"
        ]
}    
}
]
}
EOF
}
```

# Dynamo DB

*Terraform example*

```hcl
resource "aws_dynamodb_table" "cars" {
  name         = "cars"
  hash_key     = "VIN"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "VIN"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "car_items" {
  table_name = aws_dynamodb_table.cars.name
  hash_key   = aws.dynamodb_table.cars.hash_key
  item       = <<EOF
{
"Manufacturer": {"S": "Toyota"},
"Make": {"S": "Corolla"},
"Year": {"N": "2004"},
"VIN" : {"S": "sdfgsdfgsdfgsdfg"},
}

EOF
}


```