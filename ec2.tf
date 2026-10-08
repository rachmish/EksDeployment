variable "security_group_id" {
  type        = string
  description = "ID of the existing security group to attach to the instance"
}

# Look up the latest Windows Server 2022 AMI published by AWS
data "aws_ssm_parameter" "windows_2022" {
  name = "/aws/service/ami-windows-latest/Windows_Server-2022-English-Full-Base"
}

# Existing security group (read only, Terraform will not change it)
data "aws_security_group" "existing" {
  id     = var.security_group_id
  vpc_id = data.aws_vpc.lab.id
}

# The EC2 instance
resource "aws_instance" "lab_test" {
  ami                    = data.aws_ssm_parameter.windows_2022.value
  instance_type          = "t3.medium"
  subnet_id              = data.aws_subnets.lab.ids[0]
  vpc_security_group_ids = [data.aws_security_group.existing.id]

  tags = {
    Name      = "tf-lab-test-01"
    ManagedBy = "terraform"
  }
}

output "instance_id" {
  value = aws_instance.lab_test.id
}

output "private_ip" {
  value = aws_instance.lab_test.private_ip
}