resource "aws_codedeploy_app" "default_codedeploy_app" {
  name             = var.application_name
  compute_platform = "ECS"
}

resource "aws_codedeploy_deployment_group" "default_codedeploy_deployment_group" {
  app_name               = aws_codedeploy_app.default_codedeploy_app.name
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  deployment_group_name  = var.codedeploy_deployment_group_name
  service_role_arn       = data.aws_iam_role.codedeploy_iam_role.arn

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 0
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = aws_ecs_cluster.default_ecs_cluster.name
    service_name = aws_ecs_service.default_ecs_service.name
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [data.aws_lb_listener.lb_listener.arn]
      }

      target_group {
        name = element(aws_lb_target_group.default_target_groups[*].name, 0)
      }

      target_group {
        name = element(aws_lb_target_group.default_target_groups[*].name, 1)
      }
    }
  }
}
