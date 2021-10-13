data "vsphere_network" "network" {
  name          = vsphere_host_port_group.pg.name
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name
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
    label = var.disk.label
    size  = var.disk.size
  }
}

