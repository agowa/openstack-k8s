resource "openstack_compute_instance_v2" "k8s-worker" {
  count = var.worker-node-count
  name = "k8s-worker-${count.index}"
  image_name = var.image-name
  flavor_name = var.worker-node-image-flavor
  key_pair = openstack_compute_keypair_v2.ssh_keypair.name
  config_drive = true
  network {
    port = openstack_networking_port_v2.k8s-worker-port.*.id[count.index]
  }
  scheduler_hints {
    group = openstack_compute_servergroup_v2.k8s-worker-affinity.id
  }
}

resource "openstack_compute_servergroup_v2" "k8s-worker-affinity" {
  name     = "k8s-worker-affinity"
  policies = ["anti-affinity"]
}
