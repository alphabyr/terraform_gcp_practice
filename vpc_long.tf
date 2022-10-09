resource "google_compute_network" "vpc_network_1" {
  name                    = "vpc-network-1"
  auto_create_subnetworks = false
  mtu                     = 1350
}

resource "google_compute_subnetwork" "subnet_1" {
  name          = "subnet-1"
  ip_cidr_range = "172.16.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.vpc_network_1.id
}

resource "google_compute_subnetwork" "subnet_2" {
  name          = "subnet-2"
  ip_cidr_range = "172.17.0.0/16"
  region        = "europe-west1"
  network       = google_compute_network.vpc_network_1.id
}

resource "google_compute_firewall" "firewall_1" {
  name    = "terraform-firewall"
  network = google_compute_network.vpc_network_1.id

  allow {
    protocol = "icmp"
  }

  source_tags = ["terraform-practice"]
}

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
