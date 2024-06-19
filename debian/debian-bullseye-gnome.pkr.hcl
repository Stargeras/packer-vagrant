source "vagrant" "image" {
  communicator = "ssh"
  source_path  = "debian/bullseye64"
  provider     = "virtualbox"
  add_force    = true
}

build {
  sources = ["source.vagrant.image"]
  
  provisioner "shell" {
    execute_command   = "sudo bash -c '{{ .Vars }} {{ .Path }}'"
    expect_disconnect = true
    environment_vars  = [
      "username=vagrant",
      "COMPONENTS=main__contrib__non-free",
      "PACKAGES=gnome__firefox-esr__chromium__epiphany-browser__neofetch__imwheel__gparted__celluloid__gnome-shell-extension-dash-to-panel__cups__awscli__dnsutils__virt-viewer__freerdp2-x11__docker.io__vim-gui-common",
      "DEBURLS=https://f5vpn.geneseo.edu/public/download/linux_f5vpn.x86_64.deb__http://cackey.rkeene.org/download/0.7.5/cackey_0.7.5-1_amd64.deb__https://vscode.download.prss.microsoft.com/dbazure/download/stable/89de5a8d4d6205e5b11647eb6a74844ca23d2573/code_1.90.0-1717531825_amd64.deb",  
      "TIMEZONE=America/New_York",
      "FAVORITEAPPS=chromium.desktop__nautilus.desktop__gnome-terminal.desktop",
      "VSCODEEXTENSIONS=hashicorp.terraform__hashicorp.hcl__eamodio.gitlens",
      "VIMEXTENSIONS=https://github.com/hashivim/vim-terraform.git",
      "GNOMESCALINGFACTOR=1.25",
    ]
    scripts = [
      "${path.root}/common/base.sh",
      "${path.root}/../common/reboot.sh",
      "${path.root}/common/packages.sh",
      "${path.root}/common/install_binaries.sh",
      "${path.root}/bullseye-gnome/material-shell.sh",
      "${path.root}/bullseye-gnome/additions.sh",
      "${path.root}/common/firefox-edits.sh",
      "${path.root}/common/vscode-extensions.sh",
      "${path.root}/common/vbox-guest-additions.sh",
      "${path.root}/common/gnome-autostart-script.sh",
      "${path.root}/common/config-gnome/general.sh",
      "${path.root}/common/config-gnome/dash-to-panel.sh",
      "${path.root}/../common/vim.sh",
      "${path.root}/common/finalize.sh",
    ]
  }
}
