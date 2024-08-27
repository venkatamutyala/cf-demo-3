
module "venkatamutyala2_cert" {
  source  = "../modules/acm"
  aliases = ["test-app2.venkatamutyala.com", "www.test-app2.venkatamutyala.com"]
}


output "venkatamutyala2_dns_options" {
  value = module.venkatamutyala2_cert.domain_validation_options
}




module "venkatamutyala2_cloudfront" {
  source             = "../modules/cloudfront"
  origin_domain_name = local.origin_domain_name
  web_acl_id         = local.web_acl_id
  tags = {
    "captain_domain"           = local.captain_domain,
    "kubernetes_resource_name" = "venkatamutyala2_cloudfront"
  }
  aliases            = module.venkatamutyala2_cert.aliases
  acm_certificate_arn = module.venkatamutyala2_cert.certificate_arn
}

output "venkatamutyala2_cdn" {
  value = module.venkatamutyala2_cloudfront.distributions
}
