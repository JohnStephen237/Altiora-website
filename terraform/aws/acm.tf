resource "aws_acm_certificate" "marketing" {
  domain_name               = var.astro_domain_name
  validation_method         = "DNS"
  subject_alternative_names = ["www.${var.astro_domain_name}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "marketing" {
  certificate_arn         = aws_acm_certificate.marketing.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}