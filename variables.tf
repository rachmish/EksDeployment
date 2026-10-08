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

variable "instance_name" {
  type        = string
  description = "Name tag for the instance"
  default     = "tf-lab-test-01"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.medium"

  validation {
    condition     = contains(["t3.medium", "t3.large", "t3.xlarge"], var.instance_type)
    error_message = "instance_type must be one of: t3.medium, t3.large, t3.xlarge."
  }
}

variable "environment" {
  type        = string
  description = "Environment name used in tags"
  default     = "lab"
}