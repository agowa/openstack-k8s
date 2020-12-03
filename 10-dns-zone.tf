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

resource "openstack_dns_recordset_v2" "master_k8s_cluster_dns_delegation" {
  zone_id     = openstack_dns_zone_v2.k8s_dns_zone.id
  name        = "cluster.${var.dns-domain}"
  description = "k8s master node"
  ttl         = 3000
  type        = "NS"
  records     = tolist(openstack_compute_instance_v2.k8s-master.*.name)
}

resource "openstack_dns_recordset_v2" "master_k8s_master_round_robin" {
  # Replacement for load balancer, as the lb is currently bugged...
  zone_id     = openstack_dns_zone_v2.k8s_dns_zone.id
  name        = "k8s-master.${var.dns-domain}"
  description = "k8s master node"
  ttl         = 3000
  type        = "AAAA"
  #records     = tolist(openstack_compute_instance_v2.k8s-master.*.network.0.fixed_ip_v6)
  records     = [tostring((openstack_compute_instance_v2.k8s-master.0).network.0.fixed_ip_v6)]
}
