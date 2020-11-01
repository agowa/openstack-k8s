resource "openstack_compute_keypair_v2" "ssh_keypair" {
  name             = "k8s-terraform-keypair"
}
