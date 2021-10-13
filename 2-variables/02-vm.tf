resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name
  resource_pool_id = var.resource_pool_id
  datastore_id     = var.datastore_id

  num_cpus = var.num_cpus
  memory   = var.memory
  guest_id = var.guest_id

  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0

  network_interface {
    network_id = var.network_id
  }

  disk {
    label = var.disk.label
    size  = var.disk.size
  }
}
