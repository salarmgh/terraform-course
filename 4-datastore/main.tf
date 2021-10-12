provider "vsphere" {
  user           = "root"
  password       = "1qaz@WSX3edc"
  vsphere_server = "172.16.8.128"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}


data "vsphere_datacenter" "datacenter" {}

data "vsphere_host" "esxi_host" {
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

resource "vsphere_vmfs_datastore" "datastore" {
  name           = "terraform-test"
  host_system_id = "${data.vsphere_host.esxi_host.id}"

  disks = [
    "mpx.vmhba0:C0:T1:L0",
  ]
}
