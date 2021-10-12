provider "vsphere" {
  user           = "root"
  password       = "1qaz@WSX3edc"
  vsphere_server = "172.16.8.128"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

resource "vsphere_virtual_machine" "vm" {
  name             = "terraform-test"
  resource_pool_id = "ha-root-pool"
  datastore_id     = "61616fc6-29c06bff-6af2-000c293e98c9"

  num_cpus = 2
  memory   = 1024
  guest_id = "other3xLinux64Guest"

  network_interface {
    network_id = "HaNetwork-VM Network"
  }

  disk {
    label = "disk0"
    size  = 20
  }
}
