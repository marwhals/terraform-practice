# Example terraform file for a bank - generated with ChatGPT

provider "aws" {
  region = "us-east-1"
}

# ------------------------
# 1. VPC and Networking
# ------------------------
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.2"

  name = "banking-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Owner       = "banking-team"
    Environment = "prod"
  }
}

# ------------------------
# 2. Security Group
# ------------------------
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTPs and SSH"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["YOUR_OFFICE_IP/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ------------------------
# 3. EC2 Web Server (Frontend)
# ------------------------
resource "aws_instance" "frontend" {
  ami           = "ami-0c55b159cbfafe1f0" # Use a hardened AMI
  instance_type = "t3.medium"
  subnet_id     = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name      = "banking-ssh-key"

  tags = {
    Name = "BankFrontend"
  }
}

# ------------------------
# 4. RDS (PostgreSQL)
# ------------------------
resource "aws_db_instance" "bank_db" {
  identifier         = "bank-db"
  engine             = "postgres"
  instance_class     = "db.t3.medium"
  allocated_storage  = 100
  name               = "banking"
  username           = "admin"
  password           = "changeMeSecurely123!"
  db_subnet_group_name = aws_db_subnet_group.bank_subnet_group.name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  storage_encrypted = true
  multi_az          = true
  skip_final_snapshot = true
}

resource "aws_db_subnet_group" "bank_subnet_group" {
  name       = "bank-db-subnet-group"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "bank-db-subnet-group"
  }
}

# ------------------------
# 5. S3 (Logs)
# ------------------------
resource "aws_s3_bucket" "logs" {
  bucket = "banking-app-logs-secure"
  force_destroy = true

  tags = {
    Name = "BankLogs"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs_encryption" {
  bucket = aws_s3_bucket.logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
