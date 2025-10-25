# -------------------------
# Variables
# -------------------------
variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}

# -------------------------
# AWS Provider
# -------------------------
provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
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

  # Remote-exec using SSM (no PEM)
  provisioner "remote-exec" {
    inline = ["echo 'SSH via SSM is working'"]

    connection {
      type        = "ssh"
      host        = self.id     # SSM targets instance ID
      bastion_host = "ssm"      # signals Terraform to use SSM
      bastion_user = "ec2-user"
    }
  }

  # Local-exec (Ansible) using AWS CLI to fetch instance IPs
  provisioner "local-exec" {
    command = <<EOT
      for ip in $(aws ec2 describe-instances --instance-ids ${self.id} \
        --query "Reservations[].Instances[].PrivateIpAddress" --output text); do
          ANSIBLE_HOST_KEY_CHECKING=False \
          ansible-playbook -i "$ip," -u ec2-user \
          playbook.yaml
      done
    EOT
  }
}
