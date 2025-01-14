## ECS
resource "aws_iam_policy" "ecs_task_policy" {
  name        = "ecs_task_policy"
  description = "A policy for ECS tasks"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy" "ecs_task_execution_policy" {
  name        = "ecs_task_execution_policy"
  description = "A policy for ECS task execution"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:*",
          "logs:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs_task_execution_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role" "ecs_task_role" {
  name = "ecs_task_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy_attach" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_task_execution_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecs_task_policy_attach" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.ecs_task_policy.arn
}

## EKS
resource "aws_iam_role" "eks_cluster_role" {
  name = "aws_eks_cluster_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
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

resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attach" {
    role        = aws_iam_role.eks_cluster_role.name
    policy_arn  = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_node_policy_attach" {
    role        = aws_iam_role.eks_node_role.name
    policy_arn  = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}
