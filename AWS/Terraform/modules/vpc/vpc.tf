resource "aws_vpc" "senaki_vpc" {
    cidr_block = var.senaki_vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = var.vpc_name
    }
}