provider "vsphere" {
  user           = "root"
  password       = "1qaz@WSX3edc"
  vsphere_server = "172.16.8.128"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "datacenter" {
  name = "dc1"
}

data "vsphere_host" "host" {
  name          = "esxi1"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

resource "vsphere_host_virtual_switch" "switch" {
  name           = "vSwitchTerraformTest"
  host_system_id = "${data.vsphere_host.host.id}"

  network_adapters = ["vmnic1", "vmnic2"]

  active_nics  = ["vmnic1", "vmnic2"]
  standby_nics = []
}
