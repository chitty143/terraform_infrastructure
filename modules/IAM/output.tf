# output "name" {
#   value = aws_iam_user.user.name
# }


output "iam_user_name" {
  value = aws_iam_user.user[0].name
}
# output "account_id" {
#   value = aws_iam_user.user.id
# }

output "first_user_id" {
  value = aws_iam_user.user[0].id
}

output "role_name" {
  value = aws_iam_role.new_role.id
}


output "policy_arn" {
  value = aws_iam_policy.cva_policy.arn
}

output "policy_arns" {
  value = var.policy_arns
}

output "user_password" {
  value     = random_password.user_password.result
  sensitive = true
}