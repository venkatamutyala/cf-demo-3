variable "aliases" {}

provider "aws" {
  region = "us-east-1"
}

resource "aws_acm_certificate" "cert" {
  domain_name       = var.aliases[0]
  validation_method = "DNS"
  subject_alternative_names = slice(var.aliases, 1, length(var.aliases))

  lifecycle {
    create_before_destroy = true
  }
}


output domain_validation_options {
    value = aws_acm_certificate.cert.domain_validation_options
}


output "certificate_arn" {
  value = aws_acm_certificate.cert.arn
}


output "aliases" {
 value   = var.aliases
}
