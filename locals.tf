locals {
  startup_script = replace(file("startup_script.sh"), "PASSWORD", var.ubuntu_password)
}