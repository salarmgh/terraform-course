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
