variable "ubuntu_password" {
  sensitive = true
  description = "Password for the linux instances"
}

variable "instances_subnet_2" {
  type = map
  description = "List of instances and their attributes"
}