
resource "aws_iam_user_login_profile" "console_login" {
  count                   = length(var.iam_user_name)
  user                    = aws_iam_user.user[count.index].name
  #password                = random_password.user_password.result
  password_reset_required = true
}


resource "random_password" "user_password" {
  length  = 16
  special = true
}

# resource "aws_iam_user_login_profile" "console_login" {
#   user                    = aws_iam_user.user.name
#   password                = random_password.user_password.result
#   password_reset_required = true
# }