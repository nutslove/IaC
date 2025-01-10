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

variable "senaki_vpc_subnet_a_id" {
    description = "The ID of senaki vpc subnet a"
    type = string
}

variable "senaki_vpc_subnet_c_id" {
    description = "The ID of senaki vpc subnet a"
    type = string
}

variable "senaki_vpc_ecs_security_group_id" {
    description = "senaki VPC security group for ecs"
    type = string
}