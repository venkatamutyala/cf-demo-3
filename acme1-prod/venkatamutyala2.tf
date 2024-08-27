
module "venkatamutyala2_cert" {
  source  = "../modules/acm"
  aliases = ["test-app2.venkatamutyala.com", "www.test-app2.venkatamutyala.com"]
}


output "venkatamutyala2_dns_options" {
  value = module.venkatamutyala2_cert.domain_validation_options
}
