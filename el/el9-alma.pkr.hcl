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
  source_path = "almalinux/9"
  provider = "virtualbox"
  add_force = true
  #ssh_username = "root"
  #ssh_password = "vagrant"
}

build {
  sources = ["source.vagrant.image"]
  
  provisioner "shell" {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    env_var_format  = "%s='%s' "
    environment_vars = [
      "username=vagrant",
      "TIMEZONE=America/New_York",
      "DNFGROUPS=gnome-desktop__fonts",
      "SYSTEMDTARGET=graphical.target",
      "PACKAGES=xdg-utils__unzip__wget__bash-completion__vim__gvim__firefox__chromium__gnome-backgrounds__neofetch__virt-viewer__podman-docker__git__gnome-tweaks__gnome-shell-extension-dash-to-dock__xorg-x11-fonts-75dpi__gnome-extensions-app",
      "RPMURLS=https://f5vpn.geneseo.edu/public/download/linux_f5vpn.x86_64.rpm__https://rpmfind.net/linux/fedora/linux/releases/34/Everything/x86_64/os/Packages/i/imwheel-1.0.0-0.7.pre12.fc34.x86_64.rpm",
      "FAVORITEAPPS=brave-browser.desktop__nautilus.desktop__gnome-terminal.desktop",
      "GNOMEEXTENSIONS=dash-to-dock@gnome-shell-extensions.gcampax.github.com",
    ]
    scripts = [
      "${path.root}/common/base.sh",
      "${path.root}/common/packages.sh",
      "${path.root}/common/enable-services.sh",
      "${path.root}/common/gnome-autostart-script.sh",
      "${path.root}/common/systemd-target.sh",
      "${path.root}/common/install_binaries.sh",
      "${path.root}/common/brave-browser.sh",
      "${path.root}/common/firefox-edits.sh",
      "${path.root}/common/modeset.sh",
      "${path.root}/common/config-gnome/general.sh",
      "${path.root}/common/config-gnome/dash-to-dock.sh",
      "${path.root}/common/config-gnome/imwheel.sh",
      "${path.root}/../common/vim.sh",
      "${path.root}/common/finalize.sh",
    ]
  }
}
