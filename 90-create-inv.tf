resource "local_file" "AnsibleInventory" {
  content = templatefile("90-inventory.tmpl", {
      kube_master = openstack_compute_instance_v2.k8s-master
      kube_master_ports = openstack_networking_port_v2.k8s-master-port
      kube_etcd   = openstack_compute_instance_v2.k8s-master
      kube_etcd_ports = openstack_networking_port_v2.k8s-master-port
      kube_node   = openstack_compute_instance_v2.k8s-worker
      kube_node_ports = openstack_networking_port_v2.k8s-worker-port
      logon_user  = var.image-logon-user
    }
  )
  filename = "inventory.ini"
  file_permission = "0440"
}
