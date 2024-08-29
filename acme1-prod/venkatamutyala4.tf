
module "venkatamutyala4_cert" {
  source  = "../modules/acm"
  aliases = ["test-app4.venkatamutyala.com", "www.test-app4.venkatamutyala.com"]
}


output "venkatamutyala4_dns_options" {
  value = module.venkatamutyala4_cert.domain_validation_options
}


module "venkatamutyala4_cloudfront" {
  source             = "../modules/cloudfront"
  origin_domain_name = local.origin_domain_name
  web_acl_id         = local.web_acl_id
  tags = {
    "captain_domain"           = local.captain_domain,
    "kubernetes_resource_name" = "venkatamutyala4_cloudfront"
  }
  aliases            = module.venkatamutyala4_cert.aliases
  acm_certificate_arn = module.venkatamutyala4_cert.certificate_arn
}

output "venkatamutyala4_cdn" {
  value = module.venkatamutyala4_cloudfront.distributions
}
