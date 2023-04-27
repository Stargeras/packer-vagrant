source "vagrant" "image" {
  communicator = "ssh"
  source_path = "debian/bullseye64"
  provider = "virtualbox"
  add_force = true
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
      "DEBURLS=https://f5vpn.geneseo.edu/public/download/linux_f5vpn.x86_64.deb__http://cackey.rkeene.org/download/0.7.5/cackey_0.7.5-1_amd64.deb__https://az764295.vo.msecnd.net/stable/704ed70d4fd1c6bd6342c436f1ede30d1cff4710/code_1.77.3-1681292746_amd64.deb",  
      "TIMEZONE=America/New_York",
      "FAVORITEAPPS=chromium.desktop__nautilus.desktop__gnome-terminal.desktop",
      "VSCODEEXTENSIONS=hashicorp.terraform__hashicorp.hcl__eamodio.gitlens",
      "GNOMESCALINGFACTOR=1.25",
    ]
    scripts = [
      "./debian/common/base.sh",
      "./debian/common/packages.sh",
      "./debian/common/install_binaries.sh",
      "./debian/bullseye-gnome/material-shell.sh",
      "./debian/common/firefox-edits.sh",
      "./debian/common/vscode-extensions.sh",
      "./debian/common/vbox-guest-additions.sh",
      "./debian/common/gnome-autostart-script.sh",
      "./debian/common/config-gnome/general.sh",
      "./debian/common/config-gnome/dash-to-panel.sh",
      "./debian/common/finalize.sh",
    ]
  }
}