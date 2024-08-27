
module "venkatamutyala_cert" {
  source  = "../modules/acm"
  aliases = ["test-app.venkatamutyala.com", "www.test-app.venkatamutyala.com"]
}


output "venkatamutyala_dns_options" {
  value = module.venkatamutyala_cert.domain_validation_options
}
