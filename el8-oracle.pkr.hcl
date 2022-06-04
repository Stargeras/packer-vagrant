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
    environment_vars = [
      "username=vagrant",
      "TIMEZONE=America/New_York",
    ]
    scripts = [
      "./el8/common/base.sh",
      "./el8/oracle/gnome.sh",
      "./el8/oracle/config.sh",
      "./el8/common/install_binaries.sh",
    ]
  }
}
