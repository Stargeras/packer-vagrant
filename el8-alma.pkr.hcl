source "vagrant" "image" {
  communicator = "ssh"
  source_path = "generic/alma8"
  provider = "virtualbox"
  add_force = false
}

build {
  sources = ["source.vagrant.image"]
  
  provisioner "shell" {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    environment_vars = [
      "username=vagrant",
      "TIMEZONE=America/New_York",
      "DNFGROUPS=gnome-desktop__fonts",
      "ENABLEDSERVICES=gdm",
      "SYSTEMDTARGET=graphical.target",
      "PACKAGES=xdg-utils__chromium__firefox__gnome-shell-extension-dash-to-panel__gnome-backgrounds__neofetch__virt-viewer__podman-docker__git",
      "RPMURLS=https://f5vpn.geneseo.edu/public/download/linux_f5vpn.x86_64.rpm__https://az764295.vo.msecnd.net/stable/c3511e6c69bb39013c4a4b7b9566ec1ca73fc4d5/code-1.67.2-1652812909.el7.x86_64.rpm",
      "FAVORITEAPPS=firefox.desktop__nautilus.desktop__gnome-terminal.desktop"
    ]
    scripts = [
      "./el8/common/base.sh",
      "./el8/common/packages.sh",
      "./el8/common/enable-services.sh",
      "./el8/common/gnome-autostart-script.sh",
      "./el8/common/systemd-target.sh",
      "./el8/common/install_binaries.sh",
      "./el8/common/firefox-edits.sh",
      "./el8/common/config-gnome/general.sh",
      "./el8/common/config-gnome/dash-to-panel.sh",
      "./el8/common/finalize.sh",
    ]
  }
}
