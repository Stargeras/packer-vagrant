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
      "PACKAGES=pantheon__lightdm-gtk-greeter__firefox__chromium__epiphany__neofetch__imwheel__gparted__celluloid__cups__dnsutils__virt-viewer__freerdp__docker__ttf-droid__inter-font__ttf-opensans__ttf-roboto__ttf-roboto-mono__terraform__kubectl__helm__minikube__aws-cli",
      "AURPACKAGES=yay__f5vpn__cackey__switchboard-plug-pantheon-tweaks-git__visual-studio-code-bin",
      "ENABLEDSERVICES=NetworkManager__sshd__cups-browsed__docker__lightdm",
      "TIMEZONE=America/New_York",
      "FAVORITEAPPS=chromium__io.elementary.files__io.elementary.terminal__io.elementary.code__io.elementary.switchboard",
      "VSCODEEXTENSIONS=hashicorp.terraform__hashicorp.hcl",
      "GNOMESCALINGFACTOR=1.25",
    ]
    scripts           = [
      "./archlinux/common/base.sh",
      "./archlinux/common/packages.sh",
      "./archlinux/common/enable-services.sh",
      "./archlinux/common/vscode-extensions.sh",
      "./archlinux/common/gnome-autostart-script.sh",
      "./archlinux/common/firefox-edits.sh",
      "./archlinux/pantheon/additions.sh",
      "./archlinux/common/reboot.sh",
      "./archlinux/common/vbox-guest-additions.sh",
      "./archlinux/common/finalize.sh",
    ]
  }
}