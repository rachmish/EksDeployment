variable "aws_region" {
  type        = string
  description = "AWS region for all resources"
  default     = "us-east-1"
}

variable "vpc_id" {
  type        = string
  description = "ID of the existing lab VPC"
}

variable "security_group_id" {
  type        = string
  description = "ID of the existing security group to attach to instances"
}

variable "servers" {
  description = "Existing servers to look up. Key = exact Name tag in AWS."
  type = map(object({
    role = string
  }))
}

variable "environment" {
  type        = string
  description = "Environment name used in tags"
  default     = "lab"
}

variable "lab_running" {
  type        = bool
  description = "true = lab servers running, false = stopped (saves compute cost)"
  default     = true
}