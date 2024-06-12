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
  source_path = "fedora/40-cloud-base"
  provider = "virtualbox"
  add_force = true
  ssh_username = "vagrant"
  ssh_password = "vagrant"
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
      "${path.root}/common/base.sh",
      "${path.root}/common/packages.sh",
      "${path.root}/common/enable-services.sh",
      "${path.root}/common/systemd-target.sh",
      "${path.root}/common/install_binaries.sh",
      "${path.root}/common/vscode-extensions.sh",
      "${path.root}/common/config-gnome/general.sh",
      "${path.root}/common/config-gnome/dash-to-dock.sh",
      "${path.root}/common/config-gnome/imwheel.sh",
      "${path.root}/fedora/additions.sh",
      "${path.root}/common/finalize.sh",
    ]
  }
}
