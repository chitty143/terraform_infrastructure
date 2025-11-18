output "key_name" {
  value = aws_key_pair.pem_key.id
}

output "key_arn" {
  value = aws_key_pair.pem_key.arn
}

# output "pulic_ip" {
#   value = aws_instance.public_ec2.public_ip
# }

# output "private_ip" {
#   value = aws_instance.private_ec2.private_ip
# }

# output "security_group_id" {
#   value = aws_security_group.my_sg.id
# } 

output "public_instance_ids" {
  value = [for inst in aws_instance.public_ec2 : inst.id]
}

output "private_instance_ids" {
  value = [for inst in aws_instance.private_ec2 : inst.id]
}
