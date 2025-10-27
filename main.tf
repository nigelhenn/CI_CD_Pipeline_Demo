provider "aws" {
  region = var.region
  # AWS credentials are expected from environment variables
}

resource "aws_instance" "web" {
  count           = var.instance_count
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = var.security_groups

  tags = {
    Name = "web-${count.index + 1}"
  }
}
