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
  add_force    = false
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
      "PACKAGES=gnome__gnome-terminal__firefox__chromium__epiphany__neofetch__imwheel__gnome-tweaks__gnome-connections__gparted__celluloid__cups__dnsutils__virt-viewer__freerdp__docker__ttf-droid__networkmanager__gedit__terraform__kubectl__helm__minikube__aws-cli",
      "AURPACKAGES=yay__f5vpn__cackey__gnome-shell-extension-dash-to-panel__gnome-shell-extension-dash-to-dock__brave-bin__flux-bin__visual-studio-code-bin",
      "ENABLEDSERVICES=NetworkManager__gdm__sshd__cups-browsed__docker",
      "TIMEZONE=America/New_York",
      "FAVORITEAPPS=chromium.desktop__nautilus.desktop__gnome-terminal.desktop",
      "VSCODEEXTENSIONS=hashicorp.terraform__hashicorp.hcl__eamodio.gitlens",
      "GNOMESCALINGFACTOR=1.25",
    ]
    scripts           = [
      "${path.root}/common/base.sh",
      "${path.root}/common/packages.sh",
      "${path.root}/common/enable-services.sh",
      "${path.root}/common/vscode-extensions.sh",
      "${path.root}/common/firefox-edits.sh",
      "${path.root}/common/chromium-fix.sh",
      "${path.root}/common/gnome-autostart-script.sh",
      "${path.root}/common/config-gnome/general.sh",
      "${path.root}/common/config-gnome/dash-to-panel.sh",
      "${path.root}/gnome/additions.sh",
      "${path.root}/common/finalize.sh",
    ]
  }
}