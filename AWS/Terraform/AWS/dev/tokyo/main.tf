module "iam" {
  source = "../../../modules/iam"
}

module "vpc" {
  source = "../../../modules/vpc"

  vpc_name = "senaki-vpc"
  senaki_vpc_cidr = "192.168.0.0/16"
  senaki_vpc_subnet_a_cidr = "192.168.1.0/24"
  senaki_vpc_subnet_c_cidr = "192.168.2.0/24"
  az_a = "ap-northeast-1a"
  az_c = "ap-northeast-1c"
}

module "ecs" {
  source = "../../../modules/ecs"

  senaki_ecs_cluster_name = "senaki-ecs"
  ecs_task_execution_role_arn = module.iam.ecs_task_execution_role_arn
  ecs_task_role_arn = module.iam.ecs_task_role_arn
  senaki_vpc_subnet_a_id = module.vpc.senaki_vpc_subnet_a_id
  senaki_vpc_subnet_c_id = module.vpc.senaki_vpc_subnet_c_id
  senaki_vpc_ecs_security_group_id = module.vpc.senaki_vpc_ecs_security_group_id
}

module "eks" {
  source = "../../../modules/eks"

  platform_auto_mode_cluster_name = "senaki-eks-cluster-auto-mode"
  platform_managed_node_cluster_name = "senaki-eks-cluster-managed-node"
  platform_cluster_name = "senaki-eks-cluster"
  platform_eks_cluster_role_arn = module.iam.platform_eks_cluster_role_arn
  platform_eks_node_role_arn = module.iam.platform_eks_node_role_arn
  platform_eks_version = "1.31"
  platform_eks_vpc_subnet_a_id = module.vpc.senaki_vpc_subnet_a_id
  platform_eks_vpc_subnet_c_id = module.vpc.senaki_vpc_subnet_c_id
  platform_eks_vpc_eks_security_group_id = module.vpc.senaki_vpc_eks_security_group_id
  platform_managed_node_cluster_node_ebs_volume_size = 50
}