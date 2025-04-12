resource "local_file" "pet" {
  filename = var.filename
  content = var.file-content["statement1"]
}

resource "random_pet" "my-pet" {
  prefix = var.prefix[0]
  separator = "var.separator"
  length = "var.length"
}

resource "aws_instance" "webserver" {
  ami = "var.ami"
  instance_type = "var.instance_type"
}

