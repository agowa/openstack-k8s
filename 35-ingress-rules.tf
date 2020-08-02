resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_2" {
  direction         = "ingress"
  ethertype         = "IPv6"
  remote_group_id   = "${openstack_networking_secgroup_v2.secgroup_k8s-cluster.id}"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_k8s-cluster.id}"
}
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_3" {
  direction         = "ingress"
  ethertype         = "IPv6"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "::/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_k8s-cluster.id}"
}
