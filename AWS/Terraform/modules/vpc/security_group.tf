resource "aws_security_group" "senaki_vpc_ecs_security_group" {
    vpc_id = aws_vpc.senaki_vpc.id
    name = "senaki-vpc-ecs-security-group"
}

resource "aws_security_group_rule" "egress_all" {
    security_group_id = aws_security_group.senaki_vpc_ecs_security_group.id
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress_http" {
    security_group_id = aws_security_group.senaki_vpc_ecs_security_group.id
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["193.186.4.153/32","106.180.208.33/32"]
}