source "vagrant" "image" {
  communicator = "ssh"
  source_path = "debian/bullseye64"
  provider = "virtualbox"
  add_force = false
}

build {
  sources = ["source.vagrant.image"]
  
  provisioner "shell" {
    execute_command = "sudo bash -c '{{ .Vars }} {{ .Path }}'"
    environment_vars = [
      "username=vagrant",
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
    ]
  }
}