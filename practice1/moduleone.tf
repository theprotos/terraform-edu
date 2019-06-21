##################################################################################
# VARIABLES
##################################################################################

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}
variable "key_name" {
  default = "my-key"
}

##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "eu-west-3"
}

##################################################################################
# RESOURCES
##################################################################################

resource "aws_instance" "nginx" {
  ami = "ami-5026902d"
  instance_type = "t2.micro"
  key_name = "${var.key_name}"

  tags {
    name = "nginx"
  }

  connection {
    user = "ec2-user"
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install nginx -y",
      "sudo service nginx start"
    ]
  }
}

##################################################################################
# OUTPUT
##################################################################################

output "aws_instance_public_dns" {
  value = "${aws_instance.nginx.public_dns}"
}
