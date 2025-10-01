resource "aws_s3_bucket" "marketing" {
  bucket = var.astro_s3_bucket_name
}

resource "aws_s3_bucket_ownership_controls" "marketing" {
  bucket = aws_s3_bucket.marketing.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "marketing" {
  bucket                  = aws_s3_bucket.marketing.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "marketing" {
  bucket = aws_s3_bucket.marketing.id
  policy = jsonencode({
    Version = "2012-10-17"
     Statement = [{
      Sid       = "AllowCloudFrontReadViaOAC",
      Effect    = "Allow",
      Principal = { Service = "cloudfront.amazonaws.com" },
      Action    = ["s3:GetObject"],
      Resource  = "${aws_s3_bucket.marketing.arn}/*",
      Condition = {
        StringEquals = {
          "AWS:SourceArn" = aws_cloudfront_distribution.marketing.arn
        }
      }
    }]
  })
}