resource "aws_iam_policy" "custom_policy" {
  name = var.custom_policy_name #"CustomReadOnlyPolicy"
  #description = "Allows read-only access to S3 and EC2 resources"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:ListBucket",
          "ec2:DescribeInstances",
          "ec2:DescribeVolumes"
        ],
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_group_policy_attachment" "custom_policy_attachment" {
  group      = aws_iam_group.dev_group.name
  policy_arn = aws_iam_policy.custom_policy.arn
}

resource "aws_iam_role_policy_attachment" "custom_role_attachment" {
  role       = aws_iam_role.new_role.name
  policy_arn = aws_iam_policy.custom_policy.arn
}