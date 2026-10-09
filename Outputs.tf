output "vpc_cidr" {
  description = "CIDR block of the lab VPC"
  value       = data.aws_vpc.lab.cidr_block
}

output "subnet_ids" {
  description = "Subnets in the lab VPC"
  value       = data.aws_subnets.lab.ids
}

output "servers" {
  description = "Details of each existing lab server"
  value = {
    for name, srv in data.aws_instance.servers : name => {
      role              = var.servers[name].role
      instance_id       = srv.id
      instance_type     = srv.instance_type
      private_ip        = srv.private_ip
      availability_zone = srv.availability_zone
      subnet_id         = srv.subnet_id
      ami_id            = srv.ami
    }
  }
}