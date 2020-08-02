data "openstack_networking_network_v2" "network_wan" {
  name = "provider"
}

resource "openstack_networking_router_v2" "router_k8s" {
  name                = "router_k8s"
  admin_state_up      = true
  external_network_id = "${data.openstack_networking_network_v2.network_wan.id}"
  vendor_options {
    set_router_gateway_after_create=true
  }
}
