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

data "aws_instance" "servers" {
  for_each = var.servers

  filter {
    name   = "tag:Name"
    values = [each.key]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.lab.id]
  }

  filter {
    name   = "instance-state-name"
    values = ["running", "stopped"]
  }
}