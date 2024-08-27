locals {
  captain_domain     = "venaktamutyala.com"
  origin_domain_name = "ingress.${local.captain_domain}"
  web_acl_id         = "arn:aws:wafv2:us-east-1:785387425692:global/webacl/venkat-test-delete-me/904d9d34-2719-40f1-b80c-146c8f77b5b2"
}
