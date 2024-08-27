provider "aws" {
  region = "us-east-1"
}

variable "acm_certificate_arn" {}
variable "aliases" {}
variable "origin_domain_name" {}
variable "tags" {}
variable "web_acl_id" {}
    #acm_certificate_arn = string
    #aliases             = list(string)
    #origin_domain_name  = string
    #tags                = map(string)
    #web_acl_id          = string


resource "aws_acm_certificate_validation" "cert_validations" {
  certificate_arn         = var.acm_certificate_arn
}



module "cloudfront" {
  depends_on = [ aws_acm_certificate_validation.cert_validations ]

  source                         = "git::https://github.com/cloudposse/terraform-aws-cloudfront-cdn.git?ref=1.1.0"
  acm_certificate_arn            = var.acm_certificate_arn
  aliases                        = var.aliases
  origin_domain_name             = var.origin_domain_name
  labels_as_tags                 = []
  dns_aliases_enabled            = false
  tags                           = var.tags
  comment                        = "Managed by GlueOps Controller"
  name                           = "glueops-cluster"
  price_class                    = "PriceClass_100"
  forward_headers                = ["*"]
  forward_query_string           = true
  forward_cookies                = "all"
  default_ttl                    = 0
  logging_enabled                = false
  viewer_protocol_policy         = "redirect-to-https"
  default_root_object            = null
  max_ttl                        = 86400
  web_acl_id                     = var.web_acl_id
  origin_access_identity_enabled = false
}


output "distributions" {
  value = {
    cf_aliases     = module.cloudfront.cf_aliases
    cf_domain_name = module.cloudfront.cf_domain_name
  }
}
