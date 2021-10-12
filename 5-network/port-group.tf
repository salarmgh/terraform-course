resource "vsphere_host_port_group" "pg" {
  name                            = "terraform-test-pg"
  host_system_id      = "${data.vsphere_host.host.id}"
  virtual_switch_name = "${vsphere_host_virtual_switch.switch.name}"

  vlan_id = 1000
}
