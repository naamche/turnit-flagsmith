resource "aws_autoscaling_group" "default_autoscaling_group" {
  name                  = var.autoscaling_group_name
  max_size              = 2
  min_size              = 1
  desired_capacity      = 1
  health_check_type     = "EC2"
  vpc_zone_identifier   = [data.aws_subnet.subnet.id]
  protect_from_scale_in = true

  launch_template {
    id      = aws_launch_template.default_launch_template.id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [desired_capacity]
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = var.application_name
    propagate_at_launch = true
  }
}