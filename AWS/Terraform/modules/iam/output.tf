# output "ecs_task_execution_role_arn" {
#   value = aws_iam_role.ecs_task_execution_role.arn
# }

# output "ecs_task_role_arn" {
#   value = aws_iam_role.ecs_task_role.arn
# }

output "platform_eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "platform_eks_node_role_arn" {
  value = aws_iam_role.eks_node_role.arn
}

output "platform_eks_node_role_name" {
  value = aws_iam_role.eks_node_role.name
}

output "platform_eks_role_policy_attachments_ids" {
  description = "IDs of the attached policies to use for dependency tracking"
  value = [
    aws_iam_role_policy_attachment.eks_cluster_policy_attach.id,
    aws_iam_role_policy_attachment.eks_blockstorage_policy_attach.id,
    aws_iam_role_policy_attachment.eks_compute_policy_attach.id,
    aws_iam_role_policy_attachment.eks_lb_policy_attach.id,
    aws_iam_role_policy_attachment.eks_nw_policy_attach.id,
  ]
}