data "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
}

data "aws_lb" "lb" {
  name = var.lb_name
}

data "aws_lb_listener" "lb_listener" {
  load_balancer_arn = data.aws_lb.lb.arn
  port              = 443
}

data "aws_subnet" "subnet" {
  cidr_block = var.subnet_cidr
}

data "aws_security_group" "ec2_security_group" {
  name = var.ec2_security_group_name
}

data "aws_iam_role" "ecs_execution_role" {
  name = var.ecs_execution_role_name
}

data "aws_iam_role" "ecs_task_role" {
  name = var.ecs_task_role_name
}

data "aws_iam_role" "codedeploy_role" {
  name = var.codedeploy_role_name
}

data "aws_iam_instance_profile" "ec2_instance_profile" {
  name = var.ec2_instance_profile_name
}

data "aws_route53_zone" "route53_zone" {
  name = var.route53_zone_name
}

data "aws_ssm_parameters_by_path" "postgres_ssm_parameters" {
  path = "${var.parameter_store_path_name}postgres"
}

data "aws_ssm_parameters_by_path" "common_ssm_parameters" {
  path = "${var.parameter_store_path_name}common"
}

data "aws_ssm_parameters_by_path" "flagsmith_ssm_parameters" {
  path = "${var.parameter_store_path_name}flagsmith"
}

data "aws_ssm_parameters_by_path" "flagsmith_processor_ssm_parameters" {
  path = "${var.parameter_store_path_name}flagsmith_processor"
}

data "aws_caller_identity" "current_account" {}
data "aws_region" "current_region" {}