provider "aws" {
  region = "eu-west-1"
  # AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
  # will be picked up from environment variables set in Jenkins
}

resource "aws_instance" "web" {
  count           = 1
  ami             = "ami-033a3fad07a25c231"
  instance_type   = "t3.micro"
  key_name        = "terraform"
  security_groups = ["launch-wizard-1"]

  tags = {
    Name = "web-${count.index + 1}"
  }

  # Local exec for Ansible playbook
  provisioner "local-exec" {
command = "sleep 180 && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${self.public_ip},' -u ec2-user playbook.yaml"
  }
}
