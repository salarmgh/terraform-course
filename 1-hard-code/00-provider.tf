provider "vsphere" {
  user           = "root"
  password       = "1qaz@WSX3edc"
  vsphere_server = "172.16.8.128"

  # If you have a self-signed cert
  allow_unverified_ssl = true

  version = "1.15.0"
}
