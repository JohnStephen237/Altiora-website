
resource "aws_route53_record" "altiora_www" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "www.${var.astro_domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.marketing.domain_name
    zone_id                = aws_cloudfront_distribution.marketing.hosted_zone_id
    evaluate_target_health = false
  }
}