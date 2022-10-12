locals {
    subnet_info = [for subnet in google_compute_subnetwork.subnets : "${subnet["name"]} = ${subnet["ip_cidr_range"]}"]
}