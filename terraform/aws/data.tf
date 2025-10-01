data "aws_caller_identity" "current" {}
data "aws_route53_zone" "primary" {
  name         = var.zone_name
  private_zone = false
}

data "aws_iam_policy_document" "marketing_permissions" {
  statement {
    sid     = "S3Access"
    effect  = "Allow"
    actions = ["s3:ListBucket"]
    resources = [aws_s3_bucket.marketing.arn]
  }

  statement {
    sid     = "S3Objects"
    effect  = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = ["${aws_s3_bucket.marketing.arn}/*"]
  }

  statement {
    sid     = "CloudFrontInvalidate"
    effect  = "Allow"
    actions = ["cloudfront:CreateInvalidation"]
    resources = [aws_cloudfront_distribution.marketing.arn]
  }
}

locals {
  github_oidc_provider_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
}

data "aws_acm_certificate" "altiora" {
  domain       = var.astro_domain_name       # "altiora.fit"
  statuses     = ["ISSUED", "PENDING_VALIDATION"]
  most_recent  = true
  types        = ["AMAZON_ISSUED"]
}