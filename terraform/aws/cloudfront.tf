resource "aws_cloudfront_distribution" "marketing" {
  enabled             = true
  default_root_object = "index.html"

  origin {
    domain_name = aws_s3_bucket.marketing.bucket_regional_domain_name
    origin_id   = "marketing-origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id          # ← REQUIRED
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "marketing-origin"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  aliases = ["${var.astro_domain_name}", "www.${var.astro_domain_name}"]

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  price_class = "PriceClass_100"

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.marketing.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}

resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "altiora-marketing-oac"
  description                       = "OAC for altiora.fit marketing site"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}