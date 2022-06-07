source "vagrant" "image" {
  communicator = "ssh"
  source_path  = "archlinux/archlinux"
  provider     = "virtualbox"
  add_force    = true
  // Packer sometimes needs these ssh values for some images
  ssh_username = "vagrant"
  ssh_password = "vagrant"
}

build {
  sources = ["source.vagrant.image"]
  
  provisioner "shell" {
    execute_command   = "sudo bash -c '{{ .Vars }} {{ .Path }}'"
    // pause_before      = "10s"
    expect_disconnect = true
    environment_vars  = [
      "username=vagrant",
      "PACKAGES=gnome__firefox__chromium__epiphany__neofetch__imwheel__gnome-tweaks__gparted__celluloid__cups__dnsutils__virt-viewer__freerdp__docker__code__ttf-droid__networkmanager__ttf-ubuntu-font-family__gedit__terraform__kubectl__helm__minikube__aws-cli",
      "AURPACKAGES=yay__f5vpn__cackey__gnome-shell-extension-dash-to-panel__gnome-shell-extension-dash-to-dock__humanity-icon-theme__yaru__ubuntu-backgrounds-jammy",
      "ENABLEDSERVICES=NetworkManager__gdm__sshd__cups-browsed__docker",
      "TIMEZONE=America/New_York",
      "FAVORITEAPPS=chromium.desktop__nautilus.desktop__gnome-terminal.desktop",
    ]
    scripts           = [
      "./archlinux/common/base.sh",
      "./archlinux/common/packages.sh",
      "./archlinux/common/enable-services.sh",
      "./archlinux/common/gnome-autostart-script.sh",
      "./archlinux/common/firefox-edits.sh",
      "./archlinux/common/config-gnome/general.sh",
      "./archlinux/gnome-ubuntu/additions.sh",
      "./archlinux/common/reboot.sh",
      "./archlinux/common/vbox-guest-additions.sh",
      "./archlinux/common/reboot.sh",
      "./archlinux/common/finalize.sh",
    ]
  }
}