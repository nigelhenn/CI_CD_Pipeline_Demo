# -------------------------
# Variables
# -------------------------
variable "private_key_path" {
  description = "Path to the private key file"
  type        = string
}

# -------------------------
# AWS Provider
# -------------------------
provider "aws" {
  region = "us-east-1"
  # Use environment variables for credentials
  access_key = var.aws_access_key_id != "" ? var.aws_access_key_id : null
  secret_key = var.aws_secret_access_key != "" ? var.aws_secret_access_key : null
}

# -------------------------
# EC2 Instances
# -------------------------
resource "aws_instance" "web" {
  count           = 5
  ami             = "ami-033a3fad07a25c231"
  instance_type   = "t3.micro"
  key_name        = "terraform"
  security_groups = ["launch-wizard-1"]

  tags = {
    Name = "web-${count.index + 1}"
  }

  # SSH connection for remote-exec
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.private_key_path)
    host        = self.public_ip
  }

  # Run a simple command on the instance
  provisioner "remote-exec" {
    inline = ["echo 'SSH is working'"]
  }

  # Run Ansible locally from Jenkins node
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${self.public_ip},' -u ec2-user --private-key ${var.private_key_path} playbook.yaml"
  }
}
