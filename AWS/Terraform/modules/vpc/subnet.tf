# resource "aws_subnet" "senaki_vpc_subnet_a" {
#     vpc_id                  = aws_vpc.senaki_vpc.id
#     cidr_block              = var.senaki_vpc_subnet_a_cidr
#     availability_zone       = var.az_a
#     map_public_ip_on_launch = true
#     tags = {
#         Name = "${var.vpc_name}-subnet-a"
#     }  
# }

# resource "aws_subnet" "senaki_vpc_subnet_c" {
#     vpc_id                  = aws_vpc.senaki_vpc.id
#     cidr_block              = var.senaki_vpc_subnet_c_cidr
#     availability_zone       = var.az_c
#     map_public_ip_on_launch = true
#     tags = {
#         Name = "${var.vpc_name}-subnet-c"
#     }
# }

# resource "aws_subnet" "senaki_vpc_subnet_d" {
#     vpc_id                  = aws_vpc.senaki_vpc.id
#     cidr_block              = var.senaki_vpc_subnet_d_cidr
#     availability_zone       = var.az_d
#     map_public_ip_on_launch = true
#     tags = {
#         Name = "${var.vpc_name}-subnet-d"
#     }
# }