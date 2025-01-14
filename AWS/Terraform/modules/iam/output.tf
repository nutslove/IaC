output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_task_role_arn" {
  value = aws_iam_role.ecs_task_role.arn
}

output "platform_eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "platform_eks_node_role_arn" {
  value = aws_iam_role.eks_node_role.arn
}