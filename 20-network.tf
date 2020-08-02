resource "openstack_networking_network_v2" "network_k8s" {
  name           = "network_k8s"
  admin_state_up = "true"
}
