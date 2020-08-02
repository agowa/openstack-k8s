data "openstack_networking_subnetpool_v2" "subnetpool_provider" {
  name = "${var.provider-subnetpool-name}"
}

resource "openstack_networking_subnet_v2" "subnet_k8s" {
  name       = "subnet_k8s"
  network_id = "${openstack_networking_network_v2.network_k8s.id}"
  subnetpool_id = "${data.openstack_networking_subnetpool_v2.subnetpool_provider.id}"
  prefix_length = 64
  ip_version = 6
  ipv6_address_mode = "dhcpv6-stateless"
  ipv6_ra_mode = "dhcpv6-stateless"
  enable_dhcp = true
  dns_nameservers = flatten(["${split(",", var.dns-nameservers)}"])
}
