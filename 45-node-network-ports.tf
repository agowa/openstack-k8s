resource "openstack_networking_port_v2" "k8s-worker-port" {
  count          = "${var.worker-node-count}"
  name           = "k8s-worker-port_${count.index}"
  network_id     = "${openstack_networking_network_v2.network_k8s.id}"
  admin_state_up = true
  no_fixed_ip    = true
}

resource "openstack_networking_port_v2" "k8s-master-port" {
  count          = "${var.master-node-count}"
  name           = "k8s-master-port_${count.index}"
  network_id     = "${openstack_networking_network_v2.network_k8s.id}"
  admin_state_up = true
  no_fixed_ip    = true
}
