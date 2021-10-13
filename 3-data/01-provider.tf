provider "vsphere" {
  user           = var.user.username
  password       = var.user.password
  vsphere_server = var.user.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true

  version = "1.15.0"
}
