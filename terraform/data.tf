data "aws_vpc" "vpc" {
  id = "${var.parameter_store_path_name}resource/VPC_ID"
}

data "aws_lb" "lb" {
  id = "${var.parameter_store_path_name}resource/LB_ID"
}

data "aws_lb_listener" "lb_listener" {
  load_balancer_arn = data.aws_lb.lb.arn
  port              = 443
}

data "aws_subnet" "subnet" {
  id = "${var.parameter_store_path_name}resource/SUBNET_ID"
}

data "aws_security_group" "vpc_security_group" {
  id = "${var.parameter_store_path_name}resource/VPC_SECURITY_GROUP_ID"
}

data "aws_iam_role" "ecs_execution_role" {
  name = "${var.parameter_store_path_name}resource/ECS_EXECUTION_ROLE_NAME"
}

data "aws_iam_role" "ecs_task_role" {
  name = "${var.parameter_store_path_name}resource/ECS_TASK_ROLE_NAME"
}

data "aws_iam_role" "codedeploy_iam_role" {
  name = "${var.parameter_store_path_name}resource/CODEDEPLOY_IAM_ROLE_NAME"
}

data "aws_iam_instance_profile" "iam_instance_profile" {
  name = "${var.parameter_store_path_name}resource/IAM_INSTANCE_PROFILE_NAME"
}

data "aws_ssm_parameter" "domain_name" {
  name = "${var.parameter_store_path_name}tfvars/DOMAIN_NAME"
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
data "aws_route53_zone" "route53_zone" {}