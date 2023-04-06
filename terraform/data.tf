data "aws_ssm_parameter" "vpc_id" {
  name = "${var.parameter_store_path_name}tfvars/VPC_ID"
}

data "aws_ssm_parameter" "lb_listener_arn" {
  name = "${var.parameter_store_path_name}tfvars/LB_LISTENER_ARN"
}

data "aws_ssm_parameter" "subnet_id" {
  name = "${var.parameter_store_path_name}tfvars/SUBNET_ID"
}

data "aws_ssm_parameter" "vpc_security_group_id" {
  name = "${var.parameter_store_path_name}tfvars/VPC_SECURITY_GROUP_ID"
}

data "aws_ssm_parameter" "ecs_execution_role_arn" {
  name = "${var.parameter_store_path_name}tfvars/ECS_EXECUTION_ROLE_ARN"
}

data "aws_ssm_parameter" "ecs_task_role_arn" {
  name = "${var.parameter_store_path_name}tfvars/ECS_TASK_ROLE_ARN"
}

data "aws_ssm_parameter" "iam_instance_profile_arn" {
  name = "${var.parameter_store_path_name}tfvars/IAM_INSTANCE_PROFILE_ARN"
}

data "aws_ssm_parameter" "codedeploy_iam_role_arn" {
  name = "${var.parameter_store_path_name}tfvars/CODEDEPLOY_IAM_ROLE_ARN"
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