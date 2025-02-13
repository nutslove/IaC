# output "senaki_vpc_subnet_a_id" {
#   value = aws_subnet.senaki_vpc_subnet_a.id
# }

# output "senaki_vpc_subnet_c_id" {
#   value = aws_subnet.senaki_vpc_subnet_c.id
# }

# output "senaki_vpc_ecs_security_group_id" {
#   value = aws_security_group.senaki_vpc_ecs_security_group.id
# }

output "eks_security_group_id" {
  value = aws_security_group.eks_security_group.id
}

data "aws_vpc" "sandbox_vpc" {
  filter {
    name   = "tag:Name"
    values = ["sandbox"]
  }
}