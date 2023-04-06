resource "aws_ecs_cluster" "default_ecs_cluster" {
  name = var.ecs_cluster_name
}