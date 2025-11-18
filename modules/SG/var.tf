variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "profile" {
  type    = string
  default = "Vicky"
}

variable "name" {
  type    = string
  default = "cva_sg"
}
variable "ports" {
  type    = list(number)
  default = [80, 22, 443, ]
}

variable "vpc_id" {
  description = "VPC ID to associate with the security group"
  type        = string
}