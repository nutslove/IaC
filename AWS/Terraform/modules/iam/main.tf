# ## ECS
# resource "aws_iam_policy" "ecs_task_policy" {
#   name        = "ecs_task_policy"
#   description = "A policy for ECS tasks"
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = [
#           "s3:*",
#         ]
#         Effect   = "Allow"
#         Resource = "*"
#       },
#     ]
#   })
# }

# resource "aws_iam_policy" "ecs_task_execution_policy" {
#   name        = "ecs_task_execution_policy"
#   description = "A policy for ECS task execution"
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = [
#           "ecr:*",
#           "logs:*",
#         ]
#         Effect   = "Allow"
#         Resource = "*"
#       },
#     ]
#   })
# }

# resource "aws_iam_role" "ecs_task_execution_role" {
#   name = "ecs_task_execution_role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action    = "sts:AssumeRole"
#         Effect    = "Allow"
#         Principal = {
#           Service = "ecs-tasks.amazonaws.com"
#         }
#       },
#     ]
#   })
# }

# resource "aws_iam_role" "ecs_task_role" {
#   name = "ecs_task_role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action    = "sts:AssumeRole"
#         Effect    = "Allow"
#         Principal = {
#           Service = "ecs-tasks.amazonaws.com"
#         }
#       },
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy_attach" {
#   role       = aws_iam_role.ecs_task_execution_role.name
#   policy_arn = aws_iam_policy.ecs_task_execution_policy.arn
# }

# resource "aws_iam_role_policy_attachment" "ecs_task_policy_attach" {
#   role       = aws_iam_role.ecs_task_role.name
#   policy_arn = aws_iam_policy.ecs_task_policy.arn
# }

## EKS
resource "aws_iam_role" "eks_cluster_role" {
    name = "aws_eks_cluster_role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Action    = ["sts:AssumeRole", "sts:TagSession"]
            Effect    = "Allow"
            Principal = {
                Service = "eks.amazonaws.com"
            }
        },
        ]
    })  
}

resource "aws_iam_role" "eks_node_role" {
    name                = "aws_eks_node_role"
    assume_role_policy  = jsonencode({
        Version         = "2012-10-17"
        Statement       = [
        {
            Action      = "sts:AssumeRole"
            Effect      = "Allow"
            Principal = {
                Service = "ec2.amazonaws.com"
            }
        },
        ]
    })
}

resource "aws_iam_role" "eks_pod_s3_role" {
    name = "eks_pod_s3_role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Action    = ["sts:AssumeRole", "sts:TagSession"]
            Effect    = "Allow"
            Principal = {
                Service = "pods.eks.amazonaws.com"
            }
        },
        ]
    })  
}

resource "aws_iam_role" "eks_eso_pod_role" {
    name = "eks_eso_pod_role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Action    = ["sts:AssumeRole", "sts:TagSession"]
            Effect    = "Allow"
            Principal = {
                Service = "pods.eks.amazonaws.com"
            }
        },
        ]
    })  
}

resource "aws_iam_role" "eks_grafana_pod_role" {
    name = "eks_grafana_pod_role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Action    = ["sts:AssumeRole", "sts:TagSession"]
            Effect    = "Allow"
            Principal = {
                Service = "pods.eks.amazonaws.com"
            }
        },
        ]
    })  
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attach" {
    role        = aws_iam_role.eks_cluster_role.name
    policy_arn  = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_blockstorage_policy_attach" {
    role        = aws_iam_role.eks_cluster_role.name
    policy_arn  = "arn:aws:iam::aws:policy/AmazonEKSBlockStoragePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_compute_policy_attach" {
    role        = aws_iam_role.eks_cluster_role.name
    policy_arn  = "arn:aws:iam::aws:policy/AmazonEKSComputePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_lb_policy_attach" {
    role        = aws_iam_role.eks_cluster_role.name
    policy_arn  = "arn:aws:iam::aws:policy/AmazonEKSLoadBalancingPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_nw_policy_attach" {
    role        = aws_iam_role.eks_cluster_role.name
    policy_arn  = "arn:aws:iam::aws:policy/AmazonEKSNetworkingPolicy"
}

# resource "aws_iam_role_policy_attachment" "eks_workernode_policy_attach" {
#     role        = aws_iam_role.eks_node_role.name
#     policy_arn  = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
# }

resource "aws_iam_role_policy_attachment" "eks_workernodeminimal_policy_attach" {
    role        = aws_iam_role.eks_node_role.name
    policy_arn  = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodeMinimalPolicy"
}

# resource "aws_iam_role_policy_attachment" "eks_cni_policy_attach" {
#     role        = aws_iam_role.eks_node_role.name
#     policy_arn  = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
# }

# resource "aws_iam_role_policy_attachment" "eks_ecr_policy_attach" {
#     role        = aws_iam_role.eks_node_role.name
#     policy_arn  = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
# }

resource "aws_iam_role_policy_attachment" "eks_ecr_pull_policy_attach" {
    role        = aws_iam_role.eks_node_role.name
    policy_arn  = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"
}

# resource "aws_iam_role_policy_attachment" "eks_ebs_policy_attach" {
#     role        = aws_iam_role.eks_node_role.name
#     policy_arn  = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
# }

resource "aws_iam_role_policy_attachment" "eks_efs_policy_attach" {
    role        = aws_iam_role.eks_node_role.name
    policy_arn  = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_secretmanager_policy_attach" {
    role        = aws_iam_role.eks_node_role.name
    policy_arn  = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

resource "aws_iam_role_policy_attachment" "eks_cloudwatch_policy_attach" {
    role        = aws_iam_role.eks_node_role.name
    policy_arn  = "arn:aws:iam::aws:policy/CloudWatchFullAccessV2"
}

resource "aws_iam_role_policy_attachment" "eks_s3_policy_attach" {
    role        = aws_iam_role.eks_pod_s3_role.name
    policy_arn  = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "eks_for_eso_policy_attach" {
    role        = aws_iam_role.eks_eso_pod_role.name
    policy_arn  = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

resource "aws_iam_role_policy_attachment" "eks_for_grafana_cloudwatch_policy_attach" {
    role        = aws_iam_role.eks_grafana_pod_role.name
    policy_arn  = "arn:aws:iam::aws:policy/CloudWatchFullAccessV2"
}