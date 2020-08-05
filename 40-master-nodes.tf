resource "openstack_compute_instance_v2" "k8s-master" {
  count = "${var.master-node-count}"
  name = "k8s-master-${count.index}"
  image_name = "${var.image-name}"
  flavor_name = "${var.master-node-image-flavor}"
  key_pair = "${var.key-pair}"
  config_drive = true
  security_groups = [
    "${openstack_networking_secgroup_v2.secgroup_k8s-cluster.name}"
  ]
  network {
    port = "${openstack_networking_port_v2.k8s-master-port.*.id[count.index]}"
  }
}
