resource "openstack_networking_port_v2" "k8s-worker-port" {
  count          = var.worker-node-count
  name           = "k8s-worker-port_${count.index}"
  network_id     = openstack_networking_network_v2.network_k8s.id
  admin_state_up = true
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet_k8s.id
  }
  security_group_ids = [
    openstack_networking_secgroup_v2.secgroup_k8s-cluster.id
  ]
}

resource "openstack_networking_port_v2" "k8s-master-port" {
  count          = var.master-node-count
  name           = "k8s-master-port_${count.index}"
  network_id     = openstack_networking_network_v2.network_k8s.id
  admin_state_up = true
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet_k8s.id
  }
  security_group_ids = [
    openstack_networking_secgroup_v2.secgroup_k8s-cluster.id
  ]
}
