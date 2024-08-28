
module "venkatamutyala3_cert" {
  source  = "../modules/acm"
  aliases = ["test-app3.venkatamutyala.com", "www.test-app3.venkatamutyala.com"]
}


output "venkatamutyala3_dns_options" {
  value = module.venkatamutyala3_cert.domain_validation_options
}
