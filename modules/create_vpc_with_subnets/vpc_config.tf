resource "google_compute_network" "vpc_network" {
  name                    = var.name
  auto_create_subnetworks = false
  mtu                     = 1350
}

resource "google_compute_subnetwork" "subnets" {
  for_each      = var.subnets
  name          = each.key
  ip_cidr_range = each.value["cidr"]
  region        = each.value["region"]
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_firewall" "firewall" {
  name    = "${var.name}-fw"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "icmp"
  }

  source_tags = var.network_source_tags
}
