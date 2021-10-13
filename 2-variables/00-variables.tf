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

variable "vm_name" {
  type = string
  default = "terraform-test"
}

variable "resource_pool_id" {
  type = string
  default = "ha-root-pool"
}

variable "datastore_id" {
  type = string
  default = "61657ae3-e5730763-7108-000c293e98c9"
}

variable "num_cpus" {
  type = number
  default = 2
}

variable "memory" {
  type = number
  default = 1024
}

variable "guest_id" {
  type = string
  default = "other3xLinux64Guest"
}

variable "network_id" {
  type = string
  default = "HaNetwork-VM Network"
}

variable "disk" {
  type = object({
    label = string
    size = number
  })
  default = {
    label = "disk0"
    size = 20
  }
}
