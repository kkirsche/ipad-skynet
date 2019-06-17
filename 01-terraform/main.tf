variable "do_token" {}

provider "digitalocean" {
    token = "${var.do_token}"
}

resource "digitalocean_droplet" {
  name               = "web-1"
  size               = "s-1vcpu-1gb"
  image              = "ubuntu-18-04-x64"
  region             = "nyc3"
  backups            = false
  monitoring         = false
  ipv6               = true
  private_networking = false
  ssh_keys           = []
  resize_disk        = false
  user_data          = <<EOF
#cloud-config
ssh_import_id:
  - gh:kkirsche
timezone: UTC
preserve_hostname: true
fqdn: dev.deceiveyour.team
hostname: dev
packages:
  - python3
  - python3-pip
  - build-essential
  - apt-transport-https
  - ca-certificates
  - curl
  - wget
  - gnupg-agent
  - software-properties-common
package_update: true
package_upgrade: true
package_reboot_if_required: true
EOF
}