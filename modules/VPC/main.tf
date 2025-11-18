locals {
  common_tags = {
    Name        = "my_vpc"
    Environment = "dev"
  }
  az_map = { for i, az in var.availability_zones : az => i }
}

resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block #"10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true


  tags = local.common_tags

}

resource "aws_subnet" "public" {
  cidr_block = cidrsubnet(var.cidr_block, 8, local.az_map[each.key])
  for_each   = { for az in var.availability_zones : az => az }


  vpc_id = aws_vpc.main.id
  #cidr_block        = cidrsubnet(var.cidr_block, 8, index(var.availability_zones, each.key))
  availability_zone = each.key

  tags = merge(
    local.common_tags,
    {
      Name = "Public_Subnet_${each.key}"
    }
  )
}



resource "aws_subnet" "private" {
  for_each = { for az in var.availability_zones : az => az }


  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.cidr_block, 8, local.az_map[each.key] + 10)

  #cidr_block        = cidrsubnet(var.cidr_block, 8, index(var.availability_zones, each.key) + 10)
  availability_zone = each.key

  tags = merge(
    local.common_tags,
    {
      Name = "Private_Subnet_${each.key}"
    }
  )
}



resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
      Name = "IGW"
    }
  )
}


resource "aws_eip" "example" {
  for_each = { for az in var.availability_zones : az => az }

  domain = "vpc"

  tags = merge(
    local.common_tags,
    {
      Name = "NAT_EIP_${each.key}"
    }
  )
}


resource "aws_nat_gateway" "ngw" {
  for_each = { for az in var.availability_zones : az => az }

  allocation_id = aws_eip.example[each.key].id
  subnet_id     = aws_subnet.public[each.key].id

  depends_on = [aws_internet_gateway.igw]

  tags = merge(
    local.common_tags,
    {
      Name = "NAT_Gateway_${each.key}"
    }
  )
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(
    local.common_tags,
    {
      Name = "Public_RTB"
    }
  )
}


resource "aws_route_table" "private_rtb" {
  for_each = { for az in var.availability_zones : az => az }


  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw[each.key].id
  }

  tags = merge(
    local.common_tags,
    {
      Name = "Private_RTB_${each.key}"
    }
  )
}



resource "aws_route_table_association" "public" {
  for_each       = toset(var.availability_zones)
  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public_rtb.id
}
resource "aws_route_table_association" "private" {
  for_each = { for az in var.availability_zones : az => az }

  #for_each       = toset(var.availability_zones)
  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private_rtb[each.key].id
}
