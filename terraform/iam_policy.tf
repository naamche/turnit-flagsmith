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
        "Resource" : "${aws_cloudwatch_log_group.default_cloudwatch_log_group.arn}:*"
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

resource "aws_iam_policy" "code_deploy_ecs_modification_s3_policy" {
  name        = var.codedeploy_policy_name
  description = "Code Deploy Policy for ${var.application_name}"

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : [
            "ecs:DescribeServices",
            "ecs:CreateTaskSet",
            "ecs:UpdateServicePrimaryTaskSet",
            "ecs:DeleteTaskSet",
            "elasticloadbalancing:DescribeTargetGroups",
            "elasticloadbalancing:DescribeListeners",
            "elasticloadbalancing:ModifyListener",
            "elasticloadbalancing:DescribeRules",
            "elasticloadbalancing:ModifyRule",
            "cloudwatch:DescribeAlarms",
            "s3:GetObject",
            "s3:GetObjectVersion"
          ],
          "Resource" : "*",
          "Effect" : "Allow"
        },
        {
          "Action" : [
            "iam:PassRole"
          ],
          "Effect" : "Allow",
          "Resource" : "*",
          "Condition" : {
            "StringLike" : {
              "iam:PassedToService" : [
                "ecs-tasks.amazonaws.com"
              ]
            }
          }
        }
      ]
    }
  )
}
