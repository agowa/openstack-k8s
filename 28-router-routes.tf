resource "openstack_networking_router_route_v2" "router_route_docker" {
  depends_on       = [
    openstack_networking_router_interface_v2.router_interface_k8s,
    openstack_networking_port_v2.k8s-master-port,
    openstack_networking_port_v2.k8s-worker-port
  ]
  for_each         = {for a in distinct(concat(openstack_networking_port_v2.k8s-master-port, openstack_networking_port_v2.k8s-worker-port)): a.name => a}
  router_id        = openstack_networking_router_v2.router_k8s.id
  destination_cidr = tolist(each.value.allowed_address_pairs)[0].ip_address
  next_hop         = each.value.all_fixed_ips[0]
}
