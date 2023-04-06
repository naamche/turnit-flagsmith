variable "application_name" {
  type    = string
  default = "flagsmith"
}

variable "lb_target_group_names" {
  type    = list(string)
  default = ["flagsmith-blue-tg", "flagsmith-green-tg"]
}

variable "application_port" {
  type    = number
  default = 8000
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
  default = "t3.micro"
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

variable "autoscaling_group_name" {
  type    = string
  default = "flagsmith-asg"
}

variable "launch_template_name" {
  type    = string
  default = "flagsmith-launch-template"
}

variable "codedeploy_deployment_group_name" {
  type    = string
  default = "flagsmith-codedeploy-deployment-group"
}

variable "volume_name" {
  type    = string
  default = "pgdata"
}

variable "parameter_store_path_name" {
  type    = string
  default = "/turnit/flagsmith/"
}

variable "vpc_id" {
  type = string
}

variable "lb_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "ec2_security_group_id" {
  type = string
}

variable "ecs_execution_role_name" {
  type = string
}

variable "ecs_task_role_name" {
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