variable "instance_type" {
  default     = "t3.micro"
  description = "instance type of bastion host"
}


variable "allowed_ssh_cidrs" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "List of CIDR blcok allowed to SSH to the bastion host"
}


variable "dev-pub-sub-id" {
  description = "ID of public subnet"
  type        = string
}

variable "vpc-id" {
  description = "ID of the VPC"
  type        = string
}

variable "key_pair_name" {
  description = "Name of the ec2 key pair"
  type        = string
}


