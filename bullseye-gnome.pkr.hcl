source "vagrant" "image" {
  communicator = "ssh"
  source_path = "debian/bullseye64"
  provider = "virtualbox"
  add_force = true
}

build {
  sources = ["source.vagrant.image"]
  
  provisioner "shell" {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    environment_vars = [
      "CODENAME=bullseye",
      "BUILDDIR=/srv/build-files",
      "username=vagrant",
      "TIMEZONE=America/New_York",
    ]
    scripts = [
      "./debian/common/base.sh",
      "./debian/bullseye-gnome/config.sh",
      "./debian/bullseye-gnome/gnome.sh",
      "./debian/common/install_binaries.sh",
      "./debian/common/vbox-guest-additions.sh",
    ]
  }
}
