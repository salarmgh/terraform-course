resource "vsphere_virtual_machine" "vm" {
  name             = "terraform-test"
  resource_pool_id = "ha-root-pool"
  datastore_id     = "61657ae3-e5730763-7108-000c293e98c9"

  num_cpus = 2
  memory   = 1024
  guest_id = "other3xLinux64Guest"

  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0


  network_interface {
    network_id = "HaNetwork-VM Network"
  }

  disk {
    label = "disk0"
    size  = 20
  }
}
