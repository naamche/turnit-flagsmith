resource "aws_lb_listener_rule" "default_lb_listener_rule" {
  listener_arn = data.aws_lb_listener.lb_listener.arn
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default_target_groups[0].arn
  }

  condition {
    host_header {
      values = [data.aws_ssm_parameter.domain_name.value]
    }
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
  lifecycle {
    ignore_changes = [action]
  }
}