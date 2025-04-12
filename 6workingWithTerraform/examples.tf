

# Creates the new resource before destroying the old one
resource "aws_instance" "web" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }
}

# Prevents the resource from being accidentally deleted
resource "aws_db_instance" "mydb" {
  allocated_storage = 20
  engine            = "mysql"
  instance_class    = "db.t2.micro"
  name              = "mydatabase"
  username          = "foo"
  password          = "foobarbaz"
  skip_final_snapshot = true

  lifecycle {
    prevent_destroy = true
  }
}

# Ignore updates to specific attributes (like tags) made outside of Terraform
resource "aws_instance" "web" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
  tags = {
    Name = "ProjectA-Webserver"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

# Combination
resource "aws_s3_bucket" "example" {
  bucket = "my-unique-bucket-name"

  lifecycle {
    prevent_destroy       = true
    ignore_changes        = [versioning]
    create_before_destroy = true
  }
}
