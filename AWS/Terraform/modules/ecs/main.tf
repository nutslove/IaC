resource "aws_ecs_cluster" "senaki_ecs_cluster" {
    name = var.senaki_ecs_cluster_name

    setting {
        name  = "containerInsights"
        value = "enabled"
    }
    tags = {
        Name = var.senaki_ecs_cluster_name
    }
}

resource "aws_ecs_cluster_capacity_providers" "senaki_ecs_cluster_capacity_providers" {
    cluster_name = aws_ecs_cluster.senaki_ecs_cluster.name
    capacity_providers = ["FARGATE", "FARGATE_SPOT"]
    default_capacity_provider_strategy {
        capacity_provider = "FARGATE"
        weight = 1
    }
    default_capacity_provider_strategy {
        capacity_provider = "FARGATE_SPOT"
        weight = 1
    }
}

resource "aws_ecs_task_definition" "test_ecs_task" {
    family = "test-ecs-task"
    cpu = 256
    memory = 512
    container_definitions = jsonencode([
        {
            name = "nginx-ecs-container"
            image = "nginx:latest"
            essential = true
            portMappings = [
                {
                    containerPort = 80
                    hostPort = 80
                }
            ]
        }
    ])
    requires_compatibilities = ["FARGATE"]
    network_mode = "awsvpc"
    execution_role_arn = var.ecs_task_execution_role_arn
    task_role_arn = var.ecs_task_role_arn
}

resource "aws_ecs_service" "test_ecs_service" {
    name = "test-ecs-service"
    cluster = aws_ecs_cluster.senaki_ecs_cluster.id
    task_definition = aws_ecs_task_definition.test_ecs_task.arn
    desired_count = 2
    launch_type = "FARGATE"
    network_configuration {
        subnets = [var.senaki_vpc_subnet_c_id, var.senaki_vpc_subnet_a_id]
        security_groups = [var.senaki_vpc_ecs_security_group_id]
        assign_public_ip = false
    }
}