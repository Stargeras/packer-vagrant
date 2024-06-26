source "docker" "image" {
    image = "ubuntu"
    commit = true
}

build {
  sources = ["source.docker.image"]
  
  provisioner "shell" {
    execute_command = "bash -c '{{ .Vars }} {{ .Path }}'"
    environment_vars = [
      "username=ubuntu",
      "PACKAGES=linux-image-generic__ubuntu-standard",
      "DEBURLS=",
      "TIMEZONE=America/New_York",
      "FAVORITEAPPS=chromium_chromium.desktop__nautilus.desktop__gnome-terminal.desktop",
    ]
    scripts = [
      "./ubuntu/common/base.sh",
      "./ubuntu/common/packages.sh",
      "./ubuntu/common/finalize.sh",
    ]
  }
}
