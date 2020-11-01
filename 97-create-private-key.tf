resource "local_file" "dump_ssh_private_key" {
  sensitive_content = openstack_compute_keypair_v2.ssh_keypair.private_key
  filename          = "${path.module}/.ssh.vpass"
  file_permission   = "0400"
}

resource "local_file" "dump_ssh_public_key" {
  content           = openstack_compute_keypair_v2.ssh_keypair.public_key
  filename          = "${path.module}/.ssh.pub.vpass"
}
