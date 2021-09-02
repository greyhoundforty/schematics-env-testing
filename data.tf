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

data "ibm_resource_instance" "cos_instance" {
  name              = "cdetesting-cos"
  resource_group_id = data.ibm_resource_group.project.id
  service           = "cloud-object-storage"
}

data "ibm_cos_bucket" "south" {
  bucket_name          = "south-lab-1-schematics-workspace-storage"
  resource_instance_id = data.ibm_resource_instance.cos_instance.id
  bucket_type          = "region_location"
  bucket_region        = "us-south"
}