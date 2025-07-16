variable "cluster_name" {}
variable "node_group_name" {}
variable "private_subnet_ids" {
  type = list(string)
}
variable "instance_types" {
  type    = list(string)
  default = ["t3.medium"]
}
variable "desired_size" {
  default = 2
}
variable "min_size" {
  default = 1
}
variable "max_size" {
  default = 3
}

variable "node_sg_id" {
  description = "Security group ID for EKS worker nodes"
  type        = string
}

variable "ssh_key_name" {
  description = "SSH key pair name for node group"
  type        = string
}

