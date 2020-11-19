resource "local_file" "AnsibleInventory" {
  content = templatefile("90-inventory.tmpl", {
      kube_master = openstack_compute_instance_v2.k8s-master
      kube_etcd   = openstack_compute_instance_v2.k8s-master
      kube_node   = openstack_compute_instance_v2.k8s-worker
      logon_user  = var.image-logon-user
    }
  )
  filename = "inventory.ini"
  file_permission = "0440"
}
