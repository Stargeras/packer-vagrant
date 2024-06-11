packer {
  required_plugins {
    vagrant = {
      version = "~> 1.0" # effectively 1.0.2
      source  = "github.com/hashicorp/vagrant"
    }
  }
}

source "vagrant" "image" {
  communicator = "ssh"
  source_path = "ubuntu/mantic64"
  provider = "virtualbox"
  add_force = true
}

build {
  sources = ["source.vagrant.image"]
  
  provisioner "shell" {
    execute_command = "sudo bash -c '{{ .Vars }} {{ .Path }}'"
    environment_vars = [
      "username=vagrant",
      "PACKAGES=ubuntu-desktop__firefox__chromium-browser__neofetch__imwheel__gparted__celluloid__cups__awscli__virt-viewer__freerdp2-x11__docker.io",
      "DEBURLS=https://f5vpn.geneseo.edu/public/download/linux_f5vpn.x86_64.deb__http://cackey.rkeene.org/download/0.7.5/cackey_0.7.5-1_amd64.deb__https://vscode.download.prss.microsoft.com/dbazure/download/stable/89de5a8d4d6205e5b11647eb6a74844ca23d2573/code_1.90.0-1717531825_amd64.deb",   
      "TIMEZONE=America/New_York",
      "FAVORITEAPPS=chromium_chromium.desktop__nautilus.desktop__gnome-terminal.desktop",
      "VSCODEEXTENSIONS=hashicorp.terraform__hashicorp.hcl__eamodio.gitlens",
      "GNOMESCALINGFACTOR=1.25",
    ]
    scripts = [
      "${path.root}/common/base.sh",
      "${path.root}/common/packages.sh",
      "${path.root}/common/install_binaries.sh",
      "${path.root}/common/gnome-autostart-script.sh",
      "${path.root}/common/disable-gnome-welcome-screen.sh",
      "${path.root}/common/vscode-extensions.sh",
      "${path.root}/common/vbox-guest-additions.sh",
      "${path.root}/common/config-gnome/general.sh",
      "${path.root}/common/finalize.sh",
    ]
  }
}
