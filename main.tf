locals {
  common_tags = {
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

data "aws_vpc" "lab" {
  id = var.vpc_id
}

data "aws_subnets" "lab" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.lab.id]
  }
}

data "aws_ssm_parameter" "windows_2022" {
  name = "/aws/service/ami-windows-latest/Windows_Server-2022-English-Full-Base"
}

data "aws_security_group" "existing" {
  id     = var.security_group_id
  vpc_id = data.aws_vpc.lab.id
}

module "lab_test" {
  source = "./modules/windows-server"

  name               = var.instance_name
  instance_type      = var.instance_type
  ami_id             = data.aws_ssm_parameter.windows_2022.value
  subnet_id          = data.aws_subnets.lab.ids[0]
  security_group_ids = [data.aws_security_group.existing.id]
  tags               = local.common_tags
}