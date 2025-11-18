#########CREATION OF IAM USER##########

resource "aws_iam_user" "user" {
  name  = var.iam_user_name[count.index]
  count = length(var.iam_user_name)

}


######CREATION OF IAM_USER_POLICY###########

resource "aws_iam_user_policy" "cva_policy" {
  count = length(var.iam_user_name)
  name  = "${var.iam_user_name[count.index]}-policy"
  user  = aws_iam_user.user[count.index].name



  # name = var.iam_user_policy_name
  # user = aws_iam_user.user.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}


