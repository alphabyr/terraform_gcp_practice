resource "google_compute_instance" "ubuntu_1" {
  name         = "ubuntu-1"
  machine_type = "f1-micro"
  zone         = "us-central1-a"
  hostname     = "ubuntu-1.local"
  tags         = ["terraform-practice"]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  metadata = {
    serial-port-enable = "true"
  }

  metadata_startup_script = file("startup_script.sh")

  network_interface {
    subnetwork = google_compute_subnetwork.subnet_1.name
    access_config {}
  }

  depends_on = [
    google_compute_firewall.firewall_1
  ]
}

resource "google_compute_instance" "ubuntu_2" {
  name         = "ubuntu-2"
  machine_type = "f1-micro"
  zone         = "${google_compute_subnetwork.subnet_2.region}-b"
  hostname     = "ubuntu-2.local"
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
    access_config {}
  }

  depends_on = [
    google_compute_firewall.firewall_1
  ]
}
