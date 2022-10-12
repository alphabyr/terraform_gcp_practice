variable "name" {
    type = string
}

variable "subnets" {
    type = map
}

variable "network_source_tags" {
    type = list(string)
}