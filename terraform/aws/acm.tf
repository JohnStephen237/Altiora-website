resource "aws_acm_certificate" "marketing" {
  domain_name               = var.astro_domain_name
  validation_method         = "DNS"
  subject_alternative_names = ["www.${var.astro_domain_name}"]

  lifecycle {
    create_before_destroy = true
  }
}
