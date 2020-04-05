terraform {
    required_version = ">= 0.12"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain
  validation_method = var.validation_method

  tags = {
    Environment = "prod"
  }

  lifecycle {
    create_before_destroy = true
  }
}