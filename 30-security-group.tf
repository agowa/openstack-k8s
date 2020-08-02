resource "openstack_networking_secgroup_v2" "secgroup_k8s-cluster" {
  name        = "k8s-cluster"
  description = "k8s-cluster"
  delete_default_rules = true
}
