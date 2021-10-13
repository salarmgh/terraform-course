data "vsphere_datacenter" "datacenter" {}

data "vsphere_host" "esxi_host" {
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

