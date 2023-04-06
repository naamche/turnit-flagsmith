variable "application_name" {
  type    = string
  default = "flagsmith"
}

variable "lb_listener_arn" {
  type    = string
  default = data.aws_ssm_parameter.lb_listener_arn
}

variable "lb_target_group_names" {
  type    = list(string)
  default = ["flagsmith-blue-tg", "flagsmith-green-tg"]
}

variable "application_port" {
  type    = number
  default = 8000
}

variable "vpc_id" {
  type    = string
  default = data.aws_ssm_parameter.vpc_id
}

variable "health_check_path" {
  type    = string
  default = "/health"
}

variable "host_header" {
  type    = string
  default = "config.useturnit.com"
}

variable "ami" {
  type    = string
  default = "ami-0e9663fd36090d7e0"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "subnet_id" {
  type    = string
  default = data.aws_ssm_parameter.subnet_id
}

variable "vpc_security_group_ids" {
  type    = list(string)
  default = [data.aws_ssm_parameter.vpc_security_group_id]
}

variable "ecs_cluster_name" {
  type    = string
  default = "flagsmith-ecs-cluster"
}

variable "ecs_service_name" {
  type    = string
  default = "flagsmith-ecs-service"
}

variable "ecs_task_definition_family" {
  type    = string
  default = "flagsmith-ecs-task-definition"
}

variable "ecs_execution_role_arn" {
  type    = string
  default = data.aws_ssm_parameter.ecs_execution_role_arn
}

variable "ecs_task_role_arn" {
  type    = string
  default = data.aws_ssm_parameter.ecs_task_role_arn
}

variable "autoscaling_group_name" {
  type    = string
  default = "flagsmith-asg"
}

variable "launch_template_name" {
  type    = string
  default = "flagsmith-launch-template"
}

variable "iam_instance_profile_arn" {
  type    = string
  default = data.aws_ssm_parameter.iam_instance_profile_arn
}

variable "codedeploy_deployment_group_name" {
  type    = string
  default = "flagsmith-codedeploy-deployment-group"
}

variable "codedeploy_iam_role_arn" {
  type    = string
  default = data.aws_ssm_parameter.codedeploy_iam_role_arn
}

variable "volume_name" {
  type    = string
  default = "pgdata"
}

variable "parameter_store_path_name" {
  type    = string
  default = "turnit/flagsmith/"
}