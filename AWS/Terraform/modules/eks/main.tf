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
        node_pools    = ["general-purpose","system"]
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

    depends_on = [var.eks_role_policy_attachments_ids]
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

resource "aws_eks_pod_identity_association" "s3" {
    cluster_name    = aws_eks_cluster.platform_cluster_auto_mode.name
    namespace       = "monitoring"
    service_account = "thanos-service-account"
    role_arn        = var.s3_iam_role_for_pod_arn
}

resource "aws_eks_pod_identity_association" "eso" {
    cluster_name    = aws_eks_cluster.platform_cluster_auto_mode.name
    namespace       = "external-secrets"
    service_account = "eso-service-account"
    role_arn        = var.iam_role_for_eso_pod_arn
}

# resource "aws_eks_pod_identity_association" "loki" {
#     cluster_name    = aws_eks_cluster.platform_cluster_auto_mode.name
#     namespace       = "monitoring"
#     service_account = "loki-service-account"
#     role_arn        = var.s3_iam_role_for_pod_arn
# }

# resource "aws_eks_pod_identity_association" "tempo" {
#     cluster_name    = aws_eks_cluster.platform_cluster_auto_mode.name
#     namespace       = "monitoring"
#     service_account = "tempo-service-account"
#     role_arn        = var.s3_iam_role_for_pod_arn
# }

# resource "aws_eks_pod_identity_association" "grafana" {
#     cluster_name    = aws_eks_cluster.platform_cluster_auto_mode.name
#     namespace       = "monitoring"
#     service_account = "grafana-service-account"
#     role_arn        = var.iam_role_for_grafana_pod_arn
# }


# resource "aws_eks_addon" "platform_auto_mode_cluster_coredns_addon" {
#     cluster_name = aws_eks_cluster.platform_cluster_auto_mode.name
#     addon_name   = "coredns"
# }

resource "aws_eks_addon" "platform_auto_mode_cluster_efs_addon" {
    cluster_name = aws_eks_cluster.platform_cluster_auto_mode.name
    addon_name   = "aws-efs-csi-driver"
}

resource "aws_eks_addon" "platform_auto_mode_cluster_kube_state_metrics_addon" {
    cluster_name = aws_eks_cluster.platform_cluster_auto_mode.name
    addon_name   = "kube-state-metrics"
}

resource "aws_eks_addon" "platform_auto_mode_cluster_metrics_server_addon" {
    cluster_name = aws_eks_cluster.platform_cluster_auto_mode.name
    addon_name   = "metrics-server"
}

resource "aws_eks_addon" "platform_auto_mode_cluster_node_exporter_addon" {
    cluster_name = aws_eks_cluster.platform_cluster_auto_mode.name
    addon_name   = "prometheus-node-exporter"
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