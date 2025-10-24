resource "aws_instance" "web" {
  count           = 5
  ami             = "ami-033a3fad07a25c231"
  instance_type   = "t3.micro"
  key_name        = "terraform"
  security_groups = ["launch-wizard-1"]

  tags = {
    Name = "web-${count.index + 1}"
  }

  provisioner "remote-exec" {
    inline = ["echo 'SSH is working'"]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/keys/terraform.pem")
      host        = self.public_ip
    }
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${self.public_ip},' -u ec2-user --private-key ~/keys/terraform.pem playbook.yaml"
  }
}
