output "vpc_cidr" {
  description = "CIDR block of the lab VPC"
  value       = data.aws_vpc.lab.cidr_block
}

output "subnet_ids" {
  description = "Subnets in the lab VPC"
  value       = data.aws_subnets.lab.ids
}

output "instance_id" {
  description = "ID of the lab instance"
  value       = module.lab_test.instance_id
}

output "private_ip" {
  description = "Private IP of the lab instance"
  value       = module.lab_test.private_ip
}