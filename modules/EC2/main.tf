resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "pem_key" {
  key_name   = var.key_name #"deployer-key"
  public_key = tls_private_key.example.public_key_openssh

  # provisioner "local_exec" {
  #   command = "echo '${tls_private_key.example.private_key_pem}' > ./cva.pem"
  # }
}


module "vpc" {
  source = "../../modules/vpc"
}

module "security_group" {
  source = "../../modules/sg"
  vpc_id = module.vpc.vpc_id


}


resource "aws_instance" "public_ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = module.vpc.public_subnet_ids["ap-south-1a"]
  vpc_security_group_ids      = [module.security_group.sg_id]
  associate_public_ip_address = true
  tags = {
    Name = "Public-EC2"
  }
}

resource "aws_instance" "private_ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = module.vpc.private_subnet_ids["ap-south-1b"]
  vpc_security_group_ids      = [module.security_group.sg_id]
  associate_public_ip_address = false
  tags = {
    Name = "Private-EC2"
  }
}