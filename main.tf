provider "ibm" {
  region = var.region
}

variable "region" {
  type = string
  description = ""
  default = "us-south"
}

variable "resource_group" {
  type = string
  description = ""
  default = "CDE"
}

data "external" "env" { program = ["jq", "-n", "env"] }

data "ibm_resource_group" "cde" {
  name  = var.resource_group
}

output "schematics_env" {
value = jsonencode(data.external.env)
}

output "resource_group" {
  value = data.ibm_resource_group.cde
}
