output "vpc_id" {
    value = google_compute_network.vpc_network.id
}

output "subnet_info" {
  value = local.subnet_info
}