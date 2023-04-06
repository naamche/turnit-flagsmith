resource "aws_lb_target_group" "default_target_groups" {
  count       = 2
  name        = element(var.lb_target_group_names, count.index)
  port        = var.application_port
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    enabled             = true
    interval            = 60
    path                = var.health_check_path
    matcher             = "200"
    protocol            = "HTTP"
    timeout             = 20
    port                = var.application_port
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}