variable "senaki_ecs_cluster_name" {
    description = "The name of the ECS cluster"
    type        = string
}

variable "ecs_task_execution_role_arn" {
    description = "The ARN of the ECS task execution role"
    type        = string
}

variable "ecs_task_role_arn" {
    description = "The ARN of the ECS task role"
    type        = string
}