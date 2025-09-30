variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "astro_s3_bucket_name" {
  description = "Name of the S3 bucket for the Astro site"
  type        = string
}

variable "astro_domain_name" {
  description = "The domain name for Altiora's root website"
  type        = string
}

variable "zone_name" {
  description = "Route53 hosted zone name (must end with dot)"
  type        = string
}

variable "github_owner" {
  description = "GitHub owner (user or org) for the repo"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}

variable "github_branch" {
  description = "GitHub branch name"
  type        = string
}
