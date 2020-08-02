resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_1" {
  direction         = "egress"
  ethertype         = "IPv6"
  remote_ip_prefix  = "::/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_k8s-cluster.id}"
}
