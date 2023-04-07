locals {
  common_secrets = [
    for name in data.aws_ssm_parameters_by_path.common_ssm_parameters.names :
    {
      name : reverse(split("/", name))[0]
      valueFrom : "arn:aws:ssm:${data.aws_region.current_region.name}:${data.aws_caller_identity.current_account.account_id}:parameter${name}"
    }
  ]
}

resource "aws_ecs_task_definition" "default_ecs_task_definition" {
  family                   = var.ecs_task_definition_family
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]

  volume {
    name = var.volume_name
    docker_volume_configuration {
      scope         = "shared"
      autoprovision = true
      driver        = "local"
    }
  }

  container_definitions = jsonencode([
    {
      name : "postgres"
      image : "postgres:11.12-alpine"
      memory : 600
      mountPoints : [
        {
          "sourceVolume" : var.volume_name,
          "containerPath" : "/var/lib/postgresql/data"
          "readOnly" : false
        }
      ]
      secrets : [
        for name in data.aws_ssm_parameters_by_path.postgres_ssm_parameters.names :
        {
          name : reverse(split("/", name))[0]
          valueFrom : "arn:aws:ssm:${data.aws_region.current_region.name}:${data.aws_caller_identity.current_account.account_id}:parameter${name}"
        }
      ]
      logConfiguration : {
        "logDriver" : "awslogs"
        "options" : {
          "awslogs-group" : var.cloudwatch_log_group_name
          "awslogs-region" : data.aws_region.current_region.name
          "awslogs-stream-prefix" : var.application_name
        }
      }
      healthCheck : {
        "command" : ["CMD-SHELL", "pg_isready"]
        "interval" : 10
        "timeout" : 5
        "retries" : 5
        "startPeriod" : 10
      }
    },
    {
      name : "flagsmith"
      image : "flagsmith/flagsmith:latest"
      memory : 600
      portMappings : [
        {
          "containerPort" : var.application_port
          "hostPort" : var.application_port
          "protocol" : "tcp"
        }
      ],
      dependsOn : [
        {
          "containerName" : "postgres"
          "condition" : "HEALTHY"
        }
      ]
      links : ["postgres:postgres"]
      secrets : concat([
        for name in data.aws_ssm_parameters_by_path.flagsmith_ssm_parameters.names :
        {
          name : reverse(split("/", name))[0],
          valueFrom : "arn:aws:ssm:${data.aws_region.current_region.name}:${data.aws_caller_identity.current_account.account_id}:parameter${name}"
        }
      ], local.common_secrets),
      logConfiguration : {
        "logDriver" : "awslogs"
        "options" : {
          "awslogs-group" : var.cloudwatch_log_group_name
          "awslogs-region" : data.aws_region.current_region.name
          "awslogs-stream-prefix" : var.application_name
        }
      }
    },
    {
      name : "flagsmith_processor"
      image : "flagsmith/flagsmith:latest"
      memory : 600
      entryPoint : ["python", "manage.py", "runprocessor", "--sleepintervalms", "500"]
      dependsOn : [
        {
          "containerName" : "postgres"
          condition : "HEALTHY"
        },
        {
          "containerName" : "flagsmith"
          condition : "START"
        }
      ]
      links : ["postgres:postgres"]
      secrets : concat([
        for name in data.aws_ssm_parameters_by_path.flagsmith_processor_ssm_parameters.names :
        {
          name : reverse(split("/", name))[0],
          valueFrom : "arn:aws:ssm:${data.aws_region.current_region.name}:${data.aws_caller_identity.current_account.account_id}:parameter${name}"
        }
      ], local.common_secrets)
      logConfiguration : {
        "logDriver" : "awslogs"
        "options" : {
          "awslogs-group" : var.cloudwatch_log_group_name
          "awslogs-region" : data.aws_region.current_region.name
          "awslogs-stream-prefix" : var.application_name
        }
      }
    }
  ])
}