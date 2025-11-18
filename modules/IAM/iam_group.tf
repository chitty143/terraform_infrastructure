######Create IAM GROUP#######

resource "aws_iam_group" "dev_group" {
  name = var.iam_group_name
}


#######IAM-GROUP_MEMBERSHIP#####

resource "aws_iam_group_membership" "team" {
  name = var.iam_group_name #"tf-testing-group-membership"

  users = var.iam_users

  group = var.iam_group_name
}


#############IAM_GROUP_POLICY########

resource "aws_iam_group_policy" "my_developer_policy" {
  name  = var.iam_group_policy
  group = aws_iam_group.dev_group.name

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

