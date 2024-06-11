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
  source_path = "generic/oracle8"
  provider = "virtualbox"
  add_force = true
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
      "ENABLEDSERVICES=gdm",
      "SYSTEMDTARGET=graphical.target",
      "PACKAGES=xdg-utils__chromium__firefox__gnome-shell-extension-dash-to-panel__gnome-backgrounds__neofetch__virt-viewer__freerdp__podman-docker__git__awscli__xorg-x11-fonts-75dpi__gnome-tweaks",
      "RPMURLS=https://f5vpn.geneseo.edu/public/download/linux_f5vpn.x86_64.rpm__https://az764295.vo.msecnd.net/stable/c3511e6c69bb39013c4a4b7b9566ec1ca73fc4d5/code-1.67.2-1652812909.el7.x86_64.rpm__https://ftp.lysator.liu.se/pub/opensuse/distribution/leap/15.3/repo/oss/x86_64/imwheel-1.0.0pre12-bp153.1.17.x86_64.rpm",
      "FAVORITEAPPS=brave-browser.desktop__nautilus.desktop__gnome-terminal.desktop",
      "GNOMEEXTENSIONS=dash-to-panel@gnome-shell-extensions.gcampax.github.com",
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
      "${path.root}/common/config-gnome/dash-to-panel.sh",
      "${path.root}/common/config-gnome/imwheel.sh",
      "${path.root}/common/finalize.sh",
    ]
  }
}
