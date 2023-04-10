variable "application_name" {
  type    = string
  default = "turnit-flagsmith"
}

variable "host_name" {
  type = string
}

variable "application_port" {
  type    = number
  default = 8000
}

variable "lb_target_group_names" {
  type    = list(string)
  default = ["turnit-flagsmith-blue-tg", "turnit-flagsmith-green-tg"]
}

variable "health_check_path" {
  type    = string
  default = "/health"
}

variable "ami" {
  type    = string
  default = "ami-0e9663fd36090d7e0"
}

variable "instance_type" {
  type    = string
  default = "t3.small"
}

variable "ecs_cluster_name" {
  type    = string
  default = "turnit-flagsmith-ecs-cluster"
}

variable "ecs_service_name" {
  type    = string
  default = "turnit-flagsmith-ecs-service"
}

variable "ecs_task_definition_family" {
  type    = string
  default = "turnit-flagsmith-ecs-task-definition"
}

variable "autoscaling_group_name" {
  type    = string
  default = "turnit-flagsmith-asg"
}

variable "launch_template_name" {
  type    = string
  default = "turnit-flagsmith-launch-template"
}

variable "codedeploy_deployment_group_name" {
  type    = string
  default = "turnit-flagsmith-codedeploy-deployment-group"
}

variable "volume_name" {
  type    = string
  default = "pgdata"
}

variable "parameter_store_path_name" {
  type    = string
  default = "/turnit/flagsmith/"
}

variable "ecs_execution_role_policy_name" {
  type    = string
  default = "turnit-flagsmith-ecs-execution-role-policy"
}

variable "ecs_execution_role_name" {
  type    = string
  default = "turnit-flagsmith-ecs-execution-role"
}

variable "ecs_task_role_policy_name" {
  type    = string
  default = "turnit-flagsmith-ecs-task-role-policy"
}

variable "ecs_task_role_name" {
  type    = string
  default = "turnit-flagsmith-ecs-task-role"
}

variable "all_addresses" {
  type    = string
  default = "0.0.0.0/0"
}


variable "ec2_security_group_name" {
  type    = string
  default = "turnit-flagsmith-ec2-security-group"
}

variable "vpc_name" {
  type = string
}

variable "private_subnet_names" {
  type = list(string)
}

variable "cloudwatch_log_group_name" {
  type = string
}

variable "codedeploy_config_bucket_name" {
  type = string
}

variable "lb_name" {
  type = string
}

variable "codedeploy_role_name" {
  type = string
}

variable "ec2_instance_profile_name" {
  type = string
}

variable "route53_zone_name" {
  type = string
}