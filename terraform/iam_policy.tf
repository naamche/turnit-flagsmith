resource "aws_iam_policy" "ecs_execution_role_policy" {
  name        = var.ecs_execution_role_policy_name
  description = "ECS Task Execution Policy for ${var.application_name}"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ssm:DescribeParameters"
        ],
        "Resource" : "*"
      },
      {
        "Action" : [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:CreateLogGroup",
        ],
        "Effect" : "Allow",
        "Resource" : "${data.aws_cloudwatch_log_group.cloudwatch_log_group.arn}:*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ssm:GetParameters",
          "ssm:GetParameter",
          "ssm:GetParametersByPath"
        ],
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.current_region.name}:${data.aws_caller_identity.current_account.account_id}:parameter${var.parameter_store_path_name}*",
        ]
      }
    ]
  })
}