resource "openstack_dns_zone_v2" "k8s_dns_zone" {
  name        = "${var.dns-domain}"
  email       = "${var.soa-mail-address}"
  description = "k8s cluster zone"
  ttl         = 3000
  type        = "PRIMARY"
}
