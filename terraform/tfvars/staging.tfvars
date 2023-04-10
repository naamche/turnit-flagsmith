vpc_name                      = "turnit-vpc-staging"
lb_name                       = "turnit-lb-staging"
codedeploy_role_name          = "turnit-backend-code-deploy-iam-staging"
codedeploy_config_bucket_name = "turnit-backend-codedeploy-config-bucket-staging"
ec2_instance_profile_name     = "turnit-backend-ec2-instance-profile-staging"
route53_zone_name             = "staging.useturnit.com"
host_name                     = "config.staging.useturnit.com"
cloudwatch_log_group_name     = "turnit-backend-cw-staging"
private_subnet_names           = ["turnit-private-subnet-one-staging", "turnit-private-subnet-two-staging"]