resource "null_resource" "ssh-known_hosts" {

  depends_on = [
    openstack_compute_instance_v2.k8s-master,
    openstack_compute_instance_v2.k8s-worker,
    openstack_networking_port_v2.k8s-master-port,
    openstack_networking_port_v2.k8s-worker-port,
    openstack_networking_subnet_v2.subnet_k8s
  ]

  # Clear known_hosts file
  provisioner "local-exec" {
    command = "echo \"\" > known_hosts"
  }

  # Master nodes
  provisioner "local-exec" {
    command = "echo -ne \"${join("\n",formatlist("%s,%s", openstack_compute_instance_v2.k8s-master.*.network.0.fixed_ip_v6, openstack_compute_instance_v2.k8s-master.*.name))}\" | tr \"\\n\" \"\\0\" | xargs -0 -n1 -I % sh -c \"echo % | sed -nEe 's_[][]__gm;s_(.*),(.*)_echo \\1 \\$\\(openstack console log show \\2 \\| grep ecdsa-sha2-nistp256)_ep' \" >> known_hosts"
  }

  # Worker nodes
  provisioner "local-exec" {
    command = "echo -ne \"${join("\n",formatlist("%s,%s", openstack_compute_instance_v2.k8s-worker.*.network.0.fixed_ip_v6, openstack_compute_instance_v2.k8s-worker.*.name))}\" | tr \"\\n\" \"\\0\" | xargs -0 -n1 -I % sh -c \"echo % | sed -nEe 's_[][]__gm;s_(.*),(.*)_echo \\1 \\$\\(openstack console log show \\2 \\| grep ecdsa-sha2-nistp256)_ep' \" >> known_hosts"
  }
}
