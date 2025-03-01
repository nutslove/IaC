# EKS Auto Mode
resource "aws_eks_cluster" "platform_cluster_auto_mode" {
    name = var.platform_auto_mode_cluster_name
    role_arn = var.platform_eks_cluster_role_arn
    version = var.platform_eks_version

    access_config {
        authentication_mode = "API"
    }

    vpc_config {
        endpoint_private_access = true
        endpoint_public_access  = false
        subnet_ids = [var.platform_eks_vpc_subnet_a_id, var.platform_eks_vpc_subnet_c_id]
        security_group_ids = [var.platform_eks_vpc_eks_security_group_id]
    }

    bootstrap_self_managed_addons = false

    compute_config {
        enabled       = true
        node_pools    = ["general-purpose"]
        node_role_arn = var.platform_eks_node_role_arn
    }

    kubernetes_network_config {
        elastic_load_balancing {
            enabled = true
        }
    }

    storage_config {
        block_storage {
            enabled = true
        }
    }

    tags = {
        Name = var.platform_auto_mode_cluster_name
    }
}

resource "aws_eks_access_entry" "kubectl_node" {
    cluster_name  = aws_eks_cluster.platform_cluster_auto_mode.name
    principal_arn = var.kubectl_node_iam_role_arn
}

resource "aws_eks_access_policy_association" "eks_cluster_admin_policy_association" {
    cluster_name  = aws_eks_cluster.platform_cluster_auto_mode.name
    policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
    principal_arn = var.kubectl_node_iam_role_arn

    access_scope {
        type       = "cluster"
    }
}


# ## EKS Managed Node Group
# resource "aws_eks_cluster" "platform_managed_node_cluster" {
#     name = var.platform_managed_node_cluster_name
#     role_arn = var.platform_eks_cluster_role_arn
#     version = var.platform_eks_version

#     access_config {
#         authentication_mode = "API_AND_CONFIG_MAP"
#     }

#     vpc_config {
#         endpoint_private_access = true
#         endpoint_public_access  = false
#         subnet_ids = [var.platform_eks_vpc_subnet_a_id, var.platform_eks_vpc_subnet_c_id]
#         security_group_ids = [var.platform_eks_vpc_eks_security_group_id]
#     }
# }

# resource "aws_eks_access_entry" "kubectl_node" {
#     cluster_name  = aws_eks_cluster.platform_managed_node_cluster.name
#     principal_arn = var.kubectl_node_iam_role_arn
# }

# resource "aws_eks_access_policy_association" "eks_cluster_admin_policy_association" {
#     cluster_name  = aws_eks_cluster.platform_managed_node_cluster.name
#     policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
#     principal_arn = var.kubectl_node_iam_role_arn

#     access_scope {
#         type       = "cluster"
#     }
# }

# resource "aws_launch_template" "platform_eks_cluster_launch_template" {
#     name   = "${var.platform_managed_node_cluster_name}-${var.platform_eks_version}"
#     instance_type = "t3.large"
#     key_name      = "lee-key"
#     vpc_security_group_ids = [var.platform_eks_vpc_eks_security_group_id]
#     tag_specifications {
#         resource_type = "instance"
#         tags = {
#             Name = "${var.platform_managed_node_cluster_name}-${var.platform_eks_version}"
#             OS = "linux"
#         }
#     }
#     block_device_mappings {
#         device_name        = "/dev/xvda"

#         ebs {
#             volume_size    = var.platform_managed_node_cluster_node_ebs_volume_size
#         }
#     }

#     metadata_options {
#         http_put_response_hop_limit = 2
#     }
# }

# resource "aws_eks_node_group" "platform_eks_node_group" {
#     cluster_name    = aws_eks_cluster.platform_managed_node_cluster.name
#     node_group_name = "${var.platform_managed_node_cluster_name}-group"
#     node_role_arn   = var.platform_eks_node_role_arn
#     subnet_ids      = [var.platform_eks_vpc_subnet_a_id, var.platform_eks_vpc_subnet_c_id]
#     launch_template {
#         id = aws_launch_template.platform_eks_cluster_launch_template.id
#         version = aws_launch_template.platform_eks_cluster_launch_template.latest_version
#     }
#     scaling_config {
#         desired_size = 3
#         max_size     = 3
#         min_size     = 3
#     }
#     capacity_type = "ON_DEMAND"
#     labels = {
#         "node-type" = "general-purpose"
#     }
#     tags = {
#         "Name" = "platform-eks-node-group"
#     }
# }

# resource "aws_eks_addon" "platform_managed_node_cluster_efs_addon" {
#     cluster_name = aws_eks_cluster.platform_managed_node_cluster.name
#     addon_name   = "aws-efs-csi-driver"
# }

# resource "aws_eks_addon" "platform_managed_node_cluster_ebs_addon" {
#     cluster_name = aws_eks_cluster.platform_managed_node_cluster.name
#     addon_name   = "aws-ebs-csi-driver"
# }