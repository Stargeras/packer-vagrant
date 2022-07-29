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
      "PACKAGES=gnome__firefox__chromium__epiphany__neofetch__imwheel__gnome-tweaks__gnome-connections__gparted__celluloid__cups__dnsutils__virt-viewer__freerdp__docker__code__ttf-droid__networkmanager__gedit__terraform__kubectl__helm__minikube__aws-cli",
      "AURPACKAGES=yay__f5vpn__cackey__gnome-shell-extension-dash-to-panel__gnome-shell-extension-dash-to-dock__gnome-backgrounds-lakeside-git__brave-bin__flux-bin",
      "ENABLEDSERVICES=NetworkManager__gdm__sshd__cups-browsed__docker",
      "TIMEZONE=America/New_York",
      "FAVORITEAPPS=chromium.desktop__nautilus.desktop__gnome-terminal.desktop",
      "VSCODEEXTENSIONS=hashicorp.terraform"
    ]
    scripts           = [
      "./archlinux/common/base.sh",
      "./archlinux/common/chaotic-aur.sh",
      "./archlinux/common/packages.sh",
      "./archlinux/common/enable-services.sh",
      "./archlinux/common/gnome-autostart-script.sh",
      "./archlinux/common/firefox-edits.sh",
      "./archlinux/common/chromium-fix.sh",
      "./archlinux/common/vscode-extensions.sh",
      "./archlinux/common/config-gnome/general.sh",
      "./archlinux/common/config-gnome/dash-to-panel.sh",
      "./archlinux/gnome/additions.sh",
      "./archlinux/common/finalize.sh",
    ]
  }
}