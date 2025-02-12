variable "platform_cluster_name" {
    description = "The name of the EKS cluster (Blue)"
    type        = string
}

variable "platform_managed_node_cluster_name" {
    description = "The name of the EKS cluster Managed node group"
    type        = string
}

# variable "platform_auto_mode_cluster_name" {
#     description = "The name of the EKS cluster Auto mode"
#     type        = string
# }

variable "platform_eks_cluster_role_arn" {
    description = "The ARN of the IAM role that provides permissions for the EKS cluster"
    type        = string
}

variable "platform_eks_node_role_arn" {
    description = "The ARN of the IAM role that provides permissions for the EKS nodes"
    type        = string
}

variable "platform_eks_version" {
    description = "The Kubernetes version for the EKS cluster (Blue)"
    type        = string
}

variable "platform_eks_vpc_subnet_a_id" {
    description = "The ID of the subnet a in which the EKS cluster will be deployed"
    type        = string
}

variable "platform_eks_vpc_subnet_c_id" {
    description = "The ID of the subnet c in which the EKS cluster will be deployed"
    type        = string
}

variable "platform_eks_vpc_eks_security_group_id" {
    description = "The ID of the security group for the EKS cluster"
    type        = string
}

variable "kubectl_node_iam_role_arn" {
    description = "The ARN of the IAM role that provides permissions for the kubectl node"
    type        = string
}

variable "platform_managed_node_cluster_node_ebs_volume_size" {
    description = "The size of the EBS volume for the EKS nodes"
    type        = number
}