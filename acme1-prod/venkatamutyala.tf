
module "venkatamutyala_cert" {
  source  = "../modules/acm"
  aliases = ["test-app.venkatamutyala.com", "www.test-app.venkatamutyala.com"]
}


output "venkatamutyala_dns_options" {
  value = module.venkatamutyala_cert.domain_validation_options
}


module "venkatamutyala_cloudfront" {
  source             = "../modules/cloudfront"
  origin_domain_name = local.origin_domain_name
  web_acl_id         = local.web_acl_id
  tags = {
    "captain_domain"           = local.captain_domain,
    "kubernetes_resource_name" = "venkatamutyala_cloudfront"
  }
  aliases            = module.venkatamutyala_cert.aliases
  acm_certificate_arn = module.venkatamutyala_cert.certificate_arn
}

output "venkatamutyala_cdn" {
  value = module.venkatamutyala_cloudfront.distributions
}
