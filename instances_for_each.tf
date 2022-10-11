resource "google_compute_instance" "instances_subnet_2" {

  for_each     = var.instances_subnet_2
  name         = each.key
  machine_type = each.value["machine_type"]
  zone         = "${google_compute_subnetwork.subnet_2.region}-${each.value["zone"]}"
  hostname     = "${each.key}.local"
  tags         = ["terraform-practice"]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  metadata = {
    serial-port-enable = "true"
  }

  metadata_startup_script = local.startup_script

  network_interface {
    subnetwork = google_compute_subnetwork.subnet_2.name
    # access_config {}   # this line adds a public IP to the instance
  }

  depends_on = [
    google_compute_firewall.firewall_1
  ]
}
