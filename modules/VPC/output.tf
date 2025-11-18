output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of public subnets by AZ"
  value       = { for az, subnet in aws_subnet.public : az => subnet.id }
}
# output "public_subnet_ids" {
#   description = "List of public subnet IDs"
#   value       = [for subnet in aws_subnet.public : subnet.id]
# }

# output "public_subnet_id" {
#   value = aws_subnet.public["ap-south-1a"].id  # or use each.key if using for_each
# }
output "private_subnet_ids" {
  description = "IDs of private subnets by AZ"
  value       = { for az, subnet in aws_subnet.private : az => subnet.id }
}
# output "private_subnet_ids" {
#   description = "List of private subnet IDs"
#   value       = [for subnet in aws_subnet.private : subnet.id]
# }

output "private_subnet_id" {
  value = aws_subnet.private["ap-south-1b"].id
}

output "nat_gateway_ids" {
  description = "IDs of NAT Gateways by AZ"
  value       = { for az, ngw in aws_nat_gateway.ngw : az => ngw.id }
}

output "private_route_table_ids" {
  description = "IDs of private route tables by AZ"
  value       = { for az, rtb in aws_route_table.private_rtb : az => rtb.id }
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public_rtb.id
}


# output "private_subnet_id" {
#   value = aws_subnet.private.id
# }
