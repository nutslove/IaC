resource "aws_security_group" "senaki_vpc_ecs_security_group" {
    vpc_id = aws_vpc.senaki_vpc.id
    name = "senaki-vpc-ecs-security-group"
}

resource "aws_vpc_security_group_egress_rule" "egress_all_for_ecs" {
    security_group_id = aws_security_group.senaki_vpc_ecs_security_group.id
    ip_protocol = "-1"
    cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "ingress_http" {
    security_group_id = aws_security_group.senaki_vpc_ecs_security_group.id
    from_port = 80
    to_port = 80
    ip_protocol = "tcp"
    cidr_ipv4 = "193.186.4.153/32"
}

resource "aws_security_group" "senaki_vpc_eks_security_group" {
    vpc_id = aws_vpc.senaki_vpc.id
    name = "senaki-vpc-eks-security-group"
}

resource "aws_vpc_security_group_egress_rule" "egress_all_for_eks" {
    security_group_id = aws_security_group.senaki_vpc_eks_security_group.id
    ip_protocol = "-1"
    cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "ingress_all" {
    security_group_id = aws_security_group.senaki_vpc_eks_security_group.id
    ip_protocol = "-1"
    cidr_ipv4 = "0.0.0.0/0"
}