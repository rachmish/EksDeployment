variable "vpc_id" {
  type        = string
  description = "ID of the existing lab VPC"
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

output "vpc_cidr" {
  value = data.aws_vpc.lab.cidr_block
}

output "subnet_ids" {
  value = data.aws_subnets.lab.ids
}