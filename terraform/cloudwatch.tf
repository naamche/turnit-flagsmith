resource "aws_cloudwatch_log_group" "default_cloudwatch_log_group" {
  name = var.cloudwatch_log_group_name
}