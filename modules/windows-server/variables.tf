variable "name" {
  type        = string
  description = "Name tag for the server"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.medium"
}

variable "ami_id" {
  type        = string
  description = "AMI ID to launch"
}

variable "subnet_id" {
  type        = string
  description = "Subnet to place the server in"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security groups to attach"
}

variable "tags" {
  type        = map(string)
  description = "Common tags applied to the server"
  default     = {}
}