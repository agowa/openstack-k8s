resource "null_resource" "ssh-known_hosts" {

  triggers = {
    k8s_master_id = join(",", openstack_compute_instance_v2.k8s-master.*.id)
    k8s_worker_id = join(",", openstack_compute_instance_v2.k8s-worker.*.id)
    k8s_master_port_id = join(",", openstack_networking_port_v2.k8s-master-port.*.id)
    k8s_worker_port_id = join(",", openstack_networking_port_v2.k8s-worker-port.*.id)
    k8s_subnet_id = join(",", openstack_networking_subnet_v2.subnet_k8s.*.id)
  }

  provisioner "local-exec" {
    command = "echo 'Wait 30 seconds for remote to boot up and write the ssh public key int othe log' && sleep 30"
  }

  # Clear known_hosts file
  provisioner "local-exec" {
    command = "echo \"\" > known_hosts"
  }

  # Master nodes
  provisioner "local-exec" {
    command = "echo -ne \"${join("\n",formatlist("%s,%s", openstack_compute_instance_v2.k8s-master.*.network.0.fixed_ip_v6, openstack_compute_instance_v2.k8s-master.*.name))}\" | tr \"\\n\" \"\\0\" | xargs -0 -n1 -I % sh -c \" ./create-ssh-known_hosts-line.sh %\" >> known_hosts"
  }

  # Worker nodes
  provisioner "local-exec" {
    command = "echo -ne \"${join("\n",formatlist("%s,%s", openstack_compute_instance_v2.k8s-worker.*.network.0.fixed_ip_v6, openstack_compute_instance_v2.k8s-worker.*.name))}\" | tr \"\\n\" \"\\0\" | xargs -0 -n1 -I % sh -c \" ./create-ssh-known_hosts-line.sh %\" >> known_hosts"
  }
}
