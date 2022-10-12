module "vpcs_google" {
  source              = "./modules/create_vpc_with_subnets"
  for_each            = var.vpcs_google
  name                = each.key
  subnets             = each.value["subnets"]
  network_source_tags = each.value["network_source_tags"]
}

output "subnet_info_southamerica" {
    value = module.vpcs_google["vpc-southamerica"].subnet_info
}