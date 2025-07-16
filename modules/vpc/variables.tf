variable "cidr_block" {
  description = "dev-vpc CIDR"
  default     = "10.0.0.0/16"
}


variable "pub_sub_cidr" {
  description = "CID of public subnet"
  default     = "10.0.0.0/18"
}

variable "pub_sub_az" {
  default     = "us-east-1a"
  description = "AZ of public subnet"
}

variable "pvt_sub_cidr_1" {
  description = "CIDR of pvt-sub-1"
  default     = "10.0.64.0/18"
}

variable "pvt_sub_cidr_2" {
  description = "CIDR of dev-pvt-sub-2"
  default     = "10.0.128.0/18"
}


variable "pvt_sub_az_1" {
  description = "AZ of private subnet 1"
  default     = "us-east-1b"
}

variable "pvt_sub_az_2" {
  description = "AZ of private subnet 2"
  default     = "us-east-1c"
}


