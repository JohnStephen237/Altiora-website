provider "aws" {
  region = var.aws_region
}

module "aws" {
  source = "./aws"
  astro_s3_bucket_name = var.astro_s3_bucket_name
  astro_domain_name = var.astro_domain_name
  zone_name = var.zone_name
  github_owner = var.github_owner
  github_repo = var.github_repo
  github_branch = var.github_branch
}