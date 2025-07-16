variable "name" {
  description = "Name of the EFS filesystem"
  default     = "eks-shared-efs"
}

variable "vpc_id" {
  description = "VPC ID where EFS and SG will be created"
  type        = string
}


variable "subnet_ids" {
  description = "Map of subnet names to subnet IDs"
  type        = map(string)
}


variable "efs_sg_id" {
  description = "Security Group ID to attach to EFS mount targets"
  type        = string
}

