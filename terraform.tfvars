instances_subnet_2 = {

  "linux-1" = {
    machine_type = "f1-micro"
    zone         = "b"
  }
  "linux-2" = {
    machine_type = "f1-micro"
    zone         = "b"
  }
  /*   "linux-3" = {
    machine_type = "f1-micro"
    zone         = "c"
  }
  "linux-4" = {
    machine_type = "f1-micro"
    zone         = "c"
  } */
}

vpcs_google = {

  "vpc-europe-1" = {
    "subnets" = {
      "net-1-europe-north1" = {
        "cidr"   = "10.10.10.0/24"
        "region" = "europe-north1"
      }
    }
    "network_source_tags" = ["terraform-practice", "europe"]
  }

  "vpc-southamerica" = {
    "subnets" = {
      "net-1-southamerica-west1" = {
        "cidr"   = "10.10.20.0/24"
        "region" = "southamerica-west1"
      }
      "net-1-southamerica-east1" = {
        "cidr"   = "10.10.30.0/24"
        "region" = "southamerica-east1"
      }
      "net-2-southamerica-east1" = {
        "cidr"   = "10.10.40.0/24"
        "region" = "southamerica-east1"
      }
    }
    "network_source_tags" = ["terraform-practice", "southamerica"]
  }

}
