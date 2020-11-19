resource "openstack_dns_zone_v2" "k8s_dns_zone" {
  name        = var.dns-domain
  email       = var.soa-mail-address
  description = "k8s cluster zone"
  ttl         = 3000
  type        = "PRIMARY"
}

resource "openstack_dns_recordset_v2" "master_rs_k8s_dns_zone" {
  for_each    = {for a in openstack_compute_instance_v2.k8s-master: a.name => a}
  zone_id     = openstack_dns_zone_v2.k8s_dns_zone.id
  name        = each.value.name
  description = "k8s master node"
  ttl         = 3000
  type        = "AAAA"
  records     = [trim(tostring(each.value.network.0.fixed_ip_v6), "[]")]
}

resource "openstack_dns_recordset_v2" "worker_rs_k8s_dns_zone" {
  for_each    = {for a in openstack_compute_instance_v2.k8s-worker: a.name => a}
  zone_id     = openstack_dns_zone_v2.k8s_dns_zone.id
  name        = each.value.name
  description = "k8s worker node"
  ttl         = 3000
  type        = "AAAA"
  records     = [trim(tostring(each.value.network.0.fixed_ip_v6), "[]")]
}
