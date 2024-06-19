source "vagrant" "image" {
  communicator = "ssh"
  source_path = "debian/buster64"
  provider = "virtualbox"
  add_force = true
}

build {
  sources = ["source.vagrant.image"]
  
  provisioner "shell" {
    execute_command = "sudo bash -c '{{ .Vars }} {{ .Path }}'"
    expect_disconnect = true
    environment_vars = [
      "username=vagrant",
      "COMPONENTS=main__contrib__non-free",
      "PACKAGES=gnome__firefox-esr__chromium__neofetch__imwheel__gparted__gnome-shell-extension-dash-to-panel__cups__dnsutils__virt-viewer__freerdp2-x11__docker.io__vim-gui-common",
      "DEBURLS=https://f5vpn.geneseo.edu/public/download/linux_f5vpn.x86_64.deb__http://cackey.rkeene.org/download/0.7.5/cackey_0.7.5-1_amd64.deb",  
      "TIMEZONE=America/New_York",
      "FAVORITEAPPS=chromium.desktop__nautilus.desktop__gnome-terminal.desktop",
      "VIMEXTENSIONS=https://github.com/hashivim/vim-terraform.git",
      "GNOMESCALINGFACTOR=1.25",
    ]
    scripts = [
      "${path.root}/common/base.sh",
      "${path.root}/../common/reboot.sh",
      "${path.root}/common/packages.sh",
      "${path.root}/common/install_binaries.sh",
      "${path.root}/common/firefox-edits.sh",
      "${path.root}/common/vbox-guest-additions.sh",
      "${path.root}/common/gnome-autostart-script.sh",
      "${path.root}/common/config-gnome/general.sh",
      "${path.root}/common/config-gnome/dash-to-panel.sh",
      "${path.root}/../common/vim.sh",
      "${path.root}/common/finalize.sh",
    ]
  }
}
