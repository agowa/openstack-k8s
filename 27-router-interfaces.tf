resource "openstack_networking_router_interface_v2" "router_interface_k8s" {
  router_id = openstack_networking_router_v2.router_k8s.id
  subnet_id = openstack_networking_subnet_v2.subnet_k8s.id
}
