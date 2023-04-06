resource "aws_launch_template" "default_launch_template" {
  name_prefix   = var.launch_template_name
  image_id      = var.ami
  instance_type = var.instance_type

  vpc_security_group_ids = var.vpc_security_group_ids

  user_data = base64encode(<<EOF
#! /bin/bash
sudo apt-get update
sudo echo "ECS_CLUSTER=${var.ecs_cluster_name}" >> /etc/ecs/ecs.config
EOF
  )

  iam_instance_profile {
    arn = var.iam_instance_profile_arn
  }
}
