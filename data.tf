data "external" "env" { program = ["jq", "-n", "env"] }

data "ibm_resource_group" "project" {
  name = var.resource_group
}

data "ibm_is_vpc" "project" {
  name = var.vpc_name
}

data "ibm_tg_gateway" "project" {
  name = var.transit_gateway
}

data "ibm_is_zones" "mzr" {
  region = var.region
}

data "ibm_is_region" "mzr" {
  name = var.region
}