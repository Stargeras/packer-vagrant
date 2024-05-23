packer {
  required_plugins {
    vagrant = {
      version = "~> 1.0"
      source  = "github.com/hashicorp/vagrant"
    }
  }
}

source "vagrant" "image" {
  communicator = "ssh"
  source_path = "generic/fedora39"
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
      "DNFGROUPS=workstation-product-environment__fonts",
      "ENABLEDSERVICES=gdm",
      "SYSTEMDTARGET=graphical.target",
      "PACKAGES=xdg-utils__chromium__gnome-shell-extension-dash-to-dock__neofetch__virt-viewer__freerdp__podman-docker__git__awscli__gnome-tweaks__gnome-extensions-app__imwheel__openssl__bash-completion",
      "RPMURLS=https://vpn.uphs.upenn.edu/public/download/linux_f5vpn.x86_64.rpm__https://az764295.vo.msecnd.net/stable/6261075646f055b99068d3688932416f2346dd3b/code-1.73.1-1667967421.el7.x86_64.rpm",
      "FAVORITEAPPS=brave-browser.desktop__nautilus.desktop__gnome-terminal.desktop",
      "GNOMEEXTENSIONS=",
      "VSCODEEXTENSIONS=hashicorp.terraform__hashicorp.hcl",
      "GNOMESCALINGFACTOR=1.25",
    ]
    scripts = [
      "./el/common/base.sh",
      "./el/common/packages.sh",
      "./el/common/enable-services.sh",
      "./el/common/systemd-target.sh",
      "./el/common/install_binaries.sh",
      "./el/common/brave-browser.sh",
      "./el/common/modeset.sh",
      "./el/common/vscode-extensions.sh",
      "./el/common/gnome-autostart-script.sh",
      "./el/common/config-gnome/general.sh",
      "./el/common/config-gnome/dash-to-dock.sh",
      "./el/common/config-gnome/imwheel.sh",
      "./el/fedora/additions.sh",
      "./el/common/finalize.sh",
    ]
  }
}
