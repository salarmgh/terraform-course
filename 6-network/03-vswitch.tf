resource "vsphere_host_virtual_switch" "switch" {
  name           = var.vswitch_name
  host_system_id = "${data.vsphere_host.host.id}"

  network_adapters = var.network_adapters

  active_nics  = var.active_nics
  standby_nics = var.standby_nics
}
