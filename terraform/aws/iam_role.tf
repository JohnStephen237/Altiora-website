resource "aws_iam_role" "marketing_deploy" {
  name               = "altiora-marketing-deploy"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  description        = "GitHub Actions role to deploy Altiora marketing site (S3/CloudFront)"
}