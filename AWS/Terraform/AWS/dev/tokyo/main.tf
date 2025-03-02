module "iam" {
  source = "../../../modules/iam"
}

module "vpc" {
  source = "../../../modules/vpc"
}

# module "ecs" {
#   source = "../../../modules/ecs"

#   senaki_ecs_cluster_name = "senaki-ecs"
#   ecs_task_execution_role_arn = module.iam.ecs_task_execution_role_arn
#   ecs_task_role_arn = module.iam.ecs_task_role_arn
#   senaki_vpc_subnet_a_id = module.vpc.senaki_vpc_subnet_a_id
#   senaki_vpc_subnet_c_id = module.vpc.senaki_vpc_subnet_c_id
#   senaki_vpc_ecs_security_group_id = module.vpc.senaki_vpc_ecs_security_group_id
# }

module "eks" {
  source = "../../../modules/eks"

  platform_auto_mode_cluster_name = "lee-eks-cluster-auto-mode"
  # platform_managed_node_cluster_name = "lee-eks-cluster-managed-node"
  platform_cluster_name = "lee-eks-cluster"
  platform_eks_cluster_role_arn = module.iam.platform_eks_cluster_role_arn
  platform_eks_node_role_arn = module.iam.platform_eks_node_role_arn
  # platform_eks_version = "1.32"
  platform_eks_version = "1.31"
  platform_eks_vpc_subnet_a_id = data.aws_subnet.private-subnet-0-ap-northeast-1a.id
  platform_eks_vpc_subnet_c_id = data.aws_subnet.private-subnet-1-ap-northeast-1c.id
  platform_eks_vpc_eks_security_group_id = module.vpc.eks_security_group_id
  kubectl_node_iam_role_arn = "arn:aws:iam::637423497892:role/lee-ec2-role"
  eks_role_policy_attachments_ids = module.iam.platform_eks_role_policy_attachments_ids
  # platform_managed_node_cluster_node_ebs_volume_size = 50
}