data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Federated"
      identifiers = [local.github_oidc_provider_arn]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.github_owner}/${var.github_repo}:ref:refs/heads/${var.github_branch}"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "marketing_deploy" {
  name        = "altiora-marketing-deploy"
  description = "Minimal permissions for marketing deploy (S3 sync + CF invalidation)"
  policy      = data.aws_iam_policy_document.marketing_permissions.json
}

resource "aws_iam_role_policy_attachment" "attach_marketing_deploy" {
  role       = aws_iam_role.marketing_deploy.name
  policy_arn = aws_iam_policy.marketing_deploy.arn
}
