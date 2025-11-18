variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "availability_zone" {
  description = "Availability Zone for the subnets"
  type        = string
  default     = "ap-south-1a"
}
variable "availability_zones" {
  description = "List of AZs for multi-AZ deployment"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "profile" {
  type    = string
  default = "Vicky"
}