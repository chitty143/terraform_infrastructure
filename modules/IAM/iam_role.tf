#############CREATION OF IAM_ROLE###########

resource "aws_iam_role" "new_role" {
  name = var.role_name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}


#########CREATION OF IAM_ROLE POLICY#############

resource "aws_iam_policy" "cva_policy" {
  name        = "cva-policy"
  description = "Custom EC2 describe access"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["ec2:Describe*"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}





resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.new_role.name
  policy_arn = aws_iam_policy.cva_policy.arn
}