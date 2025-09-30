terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.4.0"
    }

    github = {
      source  = "integrations/github"
      version = "6.6.0"
    }
  }
}