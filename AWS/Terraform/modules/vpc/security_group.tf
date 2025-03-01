# resource "aws_security_group" "senaki_vpc_ecs_security_group" {
#     vpc_id = aws_vpc.senaki_vpc.id
#     name = "senaki-vpc-ecs-security-group"
# }

# resource "aws_vpc_security_group_egress_rule" "egress_all_for_ecs" {
#     security_group_id = aws_security_group.senaki_vpc_ecs_security_group.id
#     ip_protocol = "-1"
#     cidr_ipv4 = "0.0.0.0/0"
# }

# resource "aws_vpc_security_group_ingress_rule" "ingress_http" {
#     security_group_id = aws_security_group.senaki_vpc_ecs_security_group.id
#     from_port = 80
#     to_port = 80
#     ip_protocol = "tcp"
#     cidr_ipv4 = "193.186.4.153/32"
# }

resource "aws_security_group" "eks_security_group" {
    vpc_id = data.aws_vpc.sandbox_vpc.id
    name = "lee-eks-security-group"
    tags = {
        Name = "lee-eks-security-group"
    }
}

resource "aws_vpc_security_group_egress_rule" "egress_all_for_eks" {
    security_group_id = aws_security_group.eks_security_group.id
    ip_protocol = "-1"
    cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "ingress_all_from_sandbox_vpc" {
    security_group_id = aws_security_group.eks_security_group.id

    cidr_ipv4 = "10.1.0.0/16"
    ip_protocol = "-1"
    description = "Allow all inbound traffic from sandbox vpc"
}

# resource "aws_vpc_security_group_ingress_rule" "ingress_https" {
#     security_group_id = aws_security_group.eks_security_group.id

#     cidr_ipv4 = "10.1.0.0/16"
#     ip_protocol = "tcp"
#     from_port = 443
#     to_port = 443
#     description = "Allow HTTPS inbound traffic for kube api server"
# }

# resource "aws_vpc_security_group_ingress_rule" "ingress_nodeport" {
#     security_group_id = aws_security_group.eks_security_group.id
#     cidr_ipv4 = "10.1.0.0/16"
#     ip_protocol = "tcp"
#     from_port = 30000
#     to_port = 32767
#     description = "Allow NodePort inbound traffic"
# }