resource "aws_launch_template" "default_launch_template" {
  name_prefix   = var.launch_template_name
  image_id      = var.ami
  instance_type = var.instance_type

  vpc_security_group_ids = [data.aws_security_group.vpc_security_group]

  user_data = base64encode(<<EOF
#! /bin/bash
sudo apt-get update
sudo echo "ECS_CLUSTER=${var.ecs_cluster_name}" >> /etc/ecs/ecs.config
EOF
  )

  iam_instance_profile {
    arn = data.aws_iam_instance_profile.iam_instance_profile.arn
  }
}
