
module "venkatamutyala3_cert" {
  source  = "../modules/acm"
  aliases = ["test-app3.venkatamutyala.com", "www.test-app3.venkatamutyala.com"]
}


output "venkatamutyala3_dns_options" {
  value = module.venkatamutyala3_cert.domain_validation_options
}


module "venkatamutyala3_cloudfront" {
  source             = "../modules/cloudfront"
  origin_domain_name = local.origin_domain_name
  web_acl_id         = local.web_acl_id
  tags = {
    "captain_domain"           = local.captain_domain,
    "kubernetes_resource_name" = "venkatamutyala3_cloudfront"
  }
  aliases            = module.venkatamutyala3_cert.aliases
  acm_certificate_arn = module.venkatamutyala3_cert.certificate_arn
}

output "venkatamutyala3_cdn" {
  value = module.venkatamutyala3_cloudfront.distributions
}
