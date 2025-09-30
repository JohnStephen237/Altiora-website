output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.marketing.id
}

output "deploy_role_arn" {
  value = aws_iam_role.marketing_deploy.arn
}

output "s3_bucket_name" {
  value = aws_s3_bucket.marketing.bucket
}