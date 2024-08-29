
module "venkatamutyala4_cert" {
  source  = "../modules/acm"
  aliases = ["test-app4.venkatamutyala.com", "www.test-app4.venkatamutyala.com"]
}


output "venkatamutyala4_dns_options" {
  value = module.venkatamutyala4_cert.domain_validation_options
}
