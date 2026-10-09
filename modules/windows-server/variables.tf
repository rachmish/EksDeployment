variable "servers" {
  description = "Existing servers to look up. Key = exact Name tag in AWS."
  type = map(object({
    role = string
  }))
}

  validation {
    condition = alltrue([
      for s in values(var.servers) :
      contains(["t3.medium", "t3.large", "t3.xlarge"], s.instance_type)
    ])
    error_message = "Each server's instance_type must be one of: t3.medium, t3.large, t3.xlarge."
  }
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

variable "lab_running" {
  type        = bool
  description = "true = lab servers running, false = stopped (saves compute cost)"
  default     = true
}