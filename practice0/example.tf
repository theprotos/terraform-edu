provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

resource "aws_instance" "first" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  depends_on = [
    "aws_s3_bucket.example"]

  provisioner "local-exec" {
    command = "echo ${aws_instance.first.public_ip} > logs/ip_address-first.txt"
  }
}

resource "aws_instance" "second" {
  ami = "${var.amis["eu-west-3"]}"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo ${aws_instance.second.public_ip} > logs/ip_address-second.txt"
  }
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.first.id}"
}

output "ip" {
  value = "${aws_eip.ip.public_ip}"
}

resource "aws_s3_bucket" "example" {
  bucket = "terraform-practice"
  acl = "private"
}
