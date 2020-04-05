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

data "aws_acm_certificate" "certdata" {
  domain = var.domain
  statuses = ["PENDING_VALIDATION"]
}

resource "aws_route53_record" "validation" {
  zone_id = var.zone_id
  name =  data.aws_acm_certificate.certdata.domain_validation_options.0.resource_record_name
  type = data.aws_acm_certificate.certdata.domain_validation_options.0.resource_record_type
  records = data.aws_acm_certificate.certdata.domain_validation_options.0.resource_record_value
  ttl = "300"
}