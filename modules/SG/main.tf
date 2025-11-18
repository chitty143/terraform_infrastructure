locals {
  common_tags = {
    Name        = "my_sg",
    Environment = "dev"
  }
}
# module "vpc" {
#   source = "../../modules/vpc"
# }


resource "aws_security_group" "my_sg" {
  name   = var.name
  vpc_id = var.vpc_id

  


  dynamic "ingress" {
  for_each = var.ports
  content {
    from_port   = ingress.value
    to_port     = ingress.value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  dynamic "egress" {
    for_each = var.ports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

    }
  }

  tags = local.common_tags
}