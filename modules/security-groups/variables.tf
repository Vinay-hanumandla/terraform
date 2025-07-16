variable "name_prefix" {
  description = "Prefix to name the SGs"
  type        = string
  default     = "eks"
}

variable "vpc_id" {
  description = "VPC ID for SGs"
  type        = string
}

