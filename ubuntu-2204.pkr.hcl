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
  source_path = "ubuntu/jammy64"
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
      "DEBURLS=https://f5vpn.geneseo.edu/public/download/linux_f5vpn.x86_64.deb__http://cackey.rkeene.org/download/0.7.5/cackey_0.7.5-1_amd64.deb__https://az764295.vo.msecnd.net/stable/704ed70d4fd1c6bd6342c436f1ede30d1cff4710/code_1.77.3-1681292746_amd64.deb",   
      "TIMEZONE=America/New_York",
      "FAVORITEAPPS=chromium_chromium.desktop__nautilus.desktop__gnome-terminal.desktop",
      "VSCODEEXTENSIONS=hashicorp.terraform__hashicorp.hcl__eamodio.gitlens",
      "GNOMESCALINGFACTOR=1.25",
    ]
    scripts = [
      "./ubuntu/common/base.sh",
      "./ubuntu/common/packages.sh",
      "./ubuntu/common/install_binaries.sh",
      "./ubuntu/common/gnome-autostart-script.sh",
      "./ubuntu/common/disable-gnome-welcome-screen.sh",
      "./ubuntu/common/firefox-edits.sh",
      "./ubuntu/common/vscode-extensions.sh",
      "./ubuntu/common/vbox-guest-additions.sh",
      "./ubuntu/common/config-gnome/general.sh",
      "./ubuntu/2204/additions.sh",
      "./ubuntu/common/finalize.sh",
    ]
  }
}
