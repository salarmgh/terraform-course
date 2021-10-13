provider "vsphere" {
  user           = var.user.username
  password       = var.user.password
  vsphere_server = var.user.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true

  version = "1.15.0"
}

data "vsphere_network" "network" {
  name          = vsphere_host_port_group.pg.name
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = "terraform-test"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = vsphere_vmfs_datastore.datastore.id

  num_cpus = var.num_cpus
  memory   = var.memory
  guest_id = var.guest_id

  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = 20
  }
}
