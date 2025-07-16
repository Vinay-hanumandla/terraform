variable "cluster_name" {
  description = "Name of the EKS cluster"
  default     = "my-eks-cluster"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs"
}

variable "k8s_version" {
  description = "Kubernetes version for the EKS cluster"
  default     = "1.32"
}

