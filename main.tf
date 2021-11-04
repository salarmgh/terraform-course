resource "alicloud_ecs_key_pair" "publickey" {
  key_pair_name = "terraform-pub-key"
  public_key    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDUdj0cCpuSGV9unMF1+pavsShMIdBpvG4jlp2p+A9dWYMYWmR0Tl5r2Cl/m00jpTmI4wYgLUhZQ1O4+Iszlg1ElkQAZNKGkTasL7MbHlfk9F076q4DTweMNBcEXSzgscHiR3vtVleTpWge2ly9kp7KwvQEyzyKIkF+Y2Tf1yXtOTg8ILWLt52bzCjBc4ubkqWnzh0tm6bGVDKEAiKJq5LUc2xLJnJmVrtAELJg1BgWqokjqUnMgjcBOhQVVH00tX+Bvh1XqScZcvAyDMecdvseGO07nw6Wn2vlRFETq8+YF8sytzRwKVlmj+uleIE9NbZqeVfiNZpNTp0NQrJ7VwdL"
  tags          = {}
}


data "alicloud_zones" "zones" {}

data "alicloud_images" "images_ds" {
  owners      = "system"
  most_recent = true
  name_regex  = "^ubuntu_20.*64"
}

resource "alicloud_vpc" "vpc" {
  vpc_name              = "terraform-vpc-test"
  cidr_block            = "172.16.0.0/12"
  secondary_cidr_blocks = []
  user_cidrs            = []
}

resource "alicloud_vswitch" "vsw" {
  vpc_id     = alicloud_vpc.vpc.id
  cidr_block = "172.16.0.0/24"
  zone_id    = data.alicloud_zones.zones.ids.0
  tags       = {}
}

resource "alicloud_security_group" "group" {
  name   = "test-security-group"
  vpc_id = alicloud_vpc.vpc.id
  tags   = {}
}

resource "alicloud_security_group_rule" "allow_all_tcp" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.group.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_instance" "instance" {
  availability_zone = data.alicloud_zones.zones.ids.0
  security_groups   = alicloud_security_group.group.*.id
  tags              = {}

  internet_charge_type = "PayByBandwidth"
  instance_charge_type = "PostPaid"

  instance_type              = "ecs.t6-c2m1.large"
  system_disk_category       = "cloud_efficiency"
  system_disk_size           = 20
  image_id                   = data.alicloud_images.images_ds.images.0.id
  instance_name              = "test_foo"
  host_name                  = "testfoo"
  vswitch_id                 = alicloud_vswitch.vsw.id
  internet_max_bandwidth_out = 10
  key_name                   = alicloud_ecs_key_pair.publickey.id

  provisioner "remote-exec" {
    inline = [
      "echo '${alicloud_instance.instance.public_ip}' > ~/mytest.txt"
    ]
    connection {
      type     = "ssh"
      user     = "root"
      host     = alicloud_instance.instance.public_ip
      private_key = "${file("/home/salarmgh/.ssh/id_rsa")}"
    }
  }
}

output "public_ip" {
  value = alicloud_instance.instance.public_ip
}
