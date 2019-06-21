variable "access_key" {
  default = ""
}
variable "secret_key" {
  default = ""
}
variable "region" {
  default = "eu-west-3"
}

variable "amis" {
  type = "map"
  default = {
    "eu-west-1" = ""
    "eu-west-2" = ""
    "eu-west-3" = ""
  }
}