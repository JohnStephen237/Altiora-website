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

    # attach function here
    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.dir_index_rewrite.arn
    }
  }

  aliases = ["${var.astro_domain_name}", "www.${var.astro_domain_name}"]

  

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  price_class = "PriceClass_100"

  viewer_certificate {
    acm_certificate_arn      = data.aws_acm_certificate.altiora.arn
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

# 1) CloudFront Function: add index.html for pretty URLs
resource "aws_cloudfront_function" "dir_index_rewrite" {
  name    = "altiora-dir-index-rewrite"
  runtime = "cloudfront-js-1.0"
  comment = "Serve /index.html for directory-like URLs"
  publish = true
  code    = <<-JS
    function handler(event) {
      var req = event.request;
      var uri = req.uri;

      // If URL ends with a slash, serve index.html
      if (uri.endsWith('/')) {
        req.uri += 'index.html';
        return req;
      }

      // If URL has no dot (no extension), treat it like a directory
      if (uri.indexOf('.') === -1) {
        req.uri += '/index.html';
      }

      return req;
    }
  JS
}