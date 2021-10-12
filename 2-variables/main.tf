provider "vsphere" {
  user           = var.user.username
  password       = var.user.password
  vsphere_server = var.user.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name
  resource_pool_id = var.resource_pool_id
  datastore_id     = var.datastore_id

  num_cpus = var.num_cpus
  memory   = var.memory
  guest_id = var.guest_id

  network_interface {
    network_id = var.network_id
  }

  disk {
    label = var.disk.label
    size  = var.disk.size
  }
}
