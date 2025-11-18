variable "iam_user_name" {
  type    = list(string)
  default = ["cva", "chitty", "jyo"]
}
variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "profile" {
  type    = string
  default = "Vicky"
}

variable "role_name" {
  type    = string
  default = "cva_role"
}

variable "role_policy" {
  type    = string
  default = "cva_role_policy"
}

variable "iam_group_name" {
  type    = string
  default = "lucky"
}

variable "iam_users" {
  type    = list(string)
  default = ["cva", "chitty", "jyo"]
}


variable "iam_user_policy_name" {
  type    = string
  default = "cva"
}


variable "iam_group_policy" {
  type    = string
  default = "cva_gp_py"
}

variable "custom_policy_name" {
  type    = string
  default = "cva_custom_py"
}

variable "policy_arns" {
  type = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"

  ]
}

