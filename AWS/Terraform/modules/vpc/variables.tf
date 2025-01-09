variable "senaki_vpc_cidr" {
    description = "The CIDR block for the VPC"
    type        = string
}

variable "vpc_name" {
    description = "The name of the VPC"
    type        = string
}

variable "senaki_vpc_subnet_a_cidr" {
    description = "The CIDR block for the VPC subnet A"
    type        = string
}

variable "senaki_vpc_subnet_c_cidr" {
    description = "The CIDR block for the VPC subnet C"
    type        = string
}

variable "az_a" {
    description = "The availability zone a"
    type        = string
}

variable "az_c" {
    description = "The availability zone c"
    type        = string
}