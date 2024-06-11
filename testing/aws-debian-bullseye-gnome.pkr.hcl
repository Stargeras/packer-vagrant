packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "debian-bullseye" {
  ami_name      = "debian-bullseye-${local.timestamp}"
  instance_type = "t2.micro"
  region        = "us-east-2"
  source_ami_filter {
    filters = {
      name                = "debian-11-amd64*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["aws-marketplace"]
  }
  ssh_username = "admin"
}

build {
  name    = "ami"
  sources = [
    "source.amazon-ebs.debian-bullseye"
  ]

  provisioner "shell" {
    execute_command = "sudo bash -c '{{ .Vars }} {{ .Path }}'"
    environment_vars = [
      "DEBIAN_FRONTEND=noninteractive",
      "username=admin",
      "CODENAME=bullseye",
      "USESECURITYREPO=true",
      "PACKAGES=gnome__firefox-esr__chromium__epiphany-browser__neofetch__imwheel__gparted__celluloid__gnome-shell-extension-dash-to-panel__cups__awscli__dnsutils__virt-viewer__freerdp2-x11__docker.io",
      "DEBURLS=https://f5vpn.geneseo.edu/public/download/linux_f5vpn.x86_64.deb__http://cackey.rkeene.org/download/0.7.5/cackey_0.7.5-1_amd64.deb__https://az764295.vo.msecnd.net/stable/c3511e6c69bb39013c4a4b7b9566ec1ca73fc4d5/code_1.67.2-1652812855_amd64.deb",  
      "TIMEZONE=America/New_York",
      "FAVORITEAPPS=chromium.desktop__nautilus.desktop__gnome-terminal.desktop",
    ]
    scripts = [
      "./debian/common/base.sh",
      "./debian/common/packages.sh",
      "./debian/common/install_binaries.sh",
      "./debian/bullseye-gnome/material-shell.sh",
      "./debian/common/gnome-autostart-script.sh",
      "./debian/common/firefox-edits.sh",
      "./debian/common/vbox-guest-additions.sh",
      "./debian/common/config-gnome/general.sh",
      "./debian/common/config-gnome/dash-to-panel.sh",
      "./debian/common/finalize.sh",
    ]
  }
  post-processor "vagrant" {
      keep_input_artifact = true
      provider_override   = "virtualbox"
  }
}
