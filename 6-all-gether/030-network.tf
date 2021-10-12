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

resource "vsphere_host_port_group" "pg" {
  name                            = "terraform-test-pg"
  host_system_id      = "${data.vsphere_host.host.id}"
  virtual_switch_name = "${vsphere_host_virtual_switch.switch.name}"

  vlan_id = 1000
}
