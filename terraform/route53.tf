resource "aws_route53_record" "backend_route53_record" {
  name    = data.aws_ssm_parameter.domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.route53_zone.zone_id
  alias {
    evaluate_target_health = false
    name                   = data.aws_lb.lb.dns_name
    zone_id                = data.aws_lb.lb.zone_id
  }
}