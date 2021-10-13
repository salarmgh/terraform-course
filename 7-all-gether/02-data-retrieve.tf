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

data "vsphere_datacenter" "dc" {
  name = "dc1"
}

data "vsphere_resource_pool" "pool" {
  name          = "cluster1/Resources"
  datacenter_id = data.vsphere_datacenter.dc.id
}

