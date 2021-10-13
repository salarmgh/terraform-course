variable "user" {
  type = object({
    username = string
    password = string
    vsphere_server = string
  })
  default = {
    username = "root"
    password = "1qaz@WSX3edc"
    vsphere_server = "172.16.8.128"
  }
}

variable "vswitch_name" {
  type = string
  default = "vSwitchTerraformTest"
}

variable "network_adapters" {
  type = list(string)
  default = ["vmnic1", "vmnic2"]
}

variable "active_nics" {
  type = list(string)
  default = ["vmnic1", "vmnic2"]
}

variable "standby_nics" {
  type = list(string)
  default = []
}

variable "pg_name" {
  type = string
  default = "terraform-test-pg"
}

variable "pg_vlan_id" {
  type = number
  default = 1000
}
