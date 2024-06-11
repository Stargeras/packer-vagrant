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
      "PACKAGES=plasma__firefox__chromium__neofetch__imwheel__gparted__celluloid__cups__dnsutils__virt-viewer__freerdp__docker__code__ttf-droid__networkmanager__kate__gwenview__dolphin__konsole__terraform__kubectl__helm__minikube__aws-cli",
      "AURPACKAGES=yay__f5vpn__cackey",
      "ENABLEDSERVICES=NetworkManager__sddm__sshd__cups-browsed__docker",
      "TIMEZONE=America/New_York",
    ]
    scripts           = [
      "${path.root}/common/base.sh",
      "${path.root}/common/packages.sh",
      "${path.root}/common/enable-services.sh",
      "${path.root}/common/firefox-edits.sh",
      "${path.root}/plasma/sddm.sh",
      "${path.root}/common/reboot.sh",
      "${path.root}/common/vbox-guest-additions.sh",
      "${path.root}/common/finalize.sh",
    ]
  }
}