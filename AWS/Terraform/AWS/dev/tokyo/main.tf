# module "iam" {
#   source = "../../../modules/iam"

#   test_iam_user_name = "senaki-test-user-from-terraform"
#   default_policy_arn = "arn:aws:iam::299413808364:policy/goa-sec_protection"
# }

module "vpc" {
  source = "../../../modules/vpc"

  vpc_name = "senaki-vpc"
  senaki_vpc_cidr = "192.168.0.0/16"
  senaki_vpc_subnet_a_cidr = "192.168.0.1/24"
  senaki_vpc_subnet_c_cidr = "192.168.0.2/24"
  az_a = "ap-northeast-1a"
  az_c = "ap-northeast-1c"
}

# module "ecs" {
  
# }

# module "eks" {
#   source = "../../../modules/eks"

#   cluster_name = "senaki-eks"
#   cluster_version = "1.31"
#   cluster_instance_type = "t2.micro"
#   cluster_min_size = 3
#   cluster_max_size = 3
#   cluster_desired_capacity = 3
#   cluster_key_name = "senaki-eks-key"
#   cluster_subnet_ids = [module.vpc.senaki_vpc_subnet_a_id, module.vpc.senaki_vpc_subnet_c_id]
#   cluster_security_group_id = module.vpc.senaki_vpc_security_group_id
# }