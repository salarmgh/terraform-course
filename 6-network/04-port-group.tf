resource "vsphere_host_port_group" "pg" {
  name                            = var.pg_name
  host_system_id      = "${data.vsphere_host.host.id}"
  virtual_switch_name = "${vsphere_host_virtual_switch.switch.name}"

  vlan_id = var.pg_vlan_id
}
