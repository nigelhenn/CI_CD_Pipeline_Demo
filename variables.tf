variable "region" {
  default = "eu-west-1"
}

variable "instance_count" {
  default = 1
}

variable "ami_id" {
  default = "ami-033a3fad07a25c231"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  default = "terraform"
}

variable "security_groups" {
  type    = list(string)
  default = ["launch-wizard-1"]
}
