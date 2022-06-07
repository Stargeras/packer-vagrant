source "vagrant" "image" {
  communicator = "ssh"
  source_path = "generic/ubuntu2204"
  provider = "virtualbox"
  add_force = true
  // Packer sometimes needs these ssh values for some images
  ssh_username = "vagrant"
  ssh_password = "vagrant"
}

build {
  sources = ["source.vagrant.image"]
  
  provisioner "shell" {
    execute_command = "sudo bash -c '{{ .Vars }} {{ .Path }}'"
    environment_vars = [
      "username=vagrant",
      "PACKAGES=ubuntu-desktop__firefox__chromium-browser__neofetch__imwheel__gparted__celluloid__cups__awscli__virt-viewer__freerdp2-x11__docker.io",
      "DEBURLS=https://f5vpn.geneseo.edu/public/download/linux_f5vpn.x86_64.deb__http://cackey.rkeene.org/download/0.7.5/cackey_0.7.5-1_amd64.deb__https://az764295.vo.msecnd.net/stable/c3511e6c69bb39013c4a4b7b9566ec1ca73fc4d5/code_1.67.2-1652812855_amd64.deb",  
      "TIMEZONE=America/New_York",
      "FAVORITEAPPS=chromium-browser.desktop__nautilus.desktop__gnome-terminal.desktop",
    ]
    scripts = [
      "./ubuntu/common/base.sh",
      "./ubuntu/common/packages.sh",
      "./ubuntu/common/install_binaries.sh",
      "./ubuntu/common/gnome-autostart-script.sh",
      "./ubuntu/common/firefox-edits.sh",
      "./ubuntu/common/vbox-guest-additions.sh",
      "./ubuntu/common/config-gnome/general.sh",
      "./ubuntu/2204/additions.sh",
      "./ubuntu/common/finalize.sh",
    ]
  }
}