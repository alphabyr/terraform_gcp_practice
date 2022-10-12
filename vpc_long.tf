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