resource "aws_lb_listener_rule" "default_lb_listener_rule" {
  listener_arn = var.lb_listener_arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default_target_groups[0].arn
  }

  condition {
    host_header {
      values = [var.host_header]
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