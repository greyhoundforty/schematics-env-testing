# output "schematics_env" {
#   value = jsonencode(data.external.env)
# }

# output "resource_group" {
#   value = data.ibm_resource_group.project
# }

# output "vpc_info" {
#   value = data.ibm_is_vpc.project
# }

output "tgw_info" {
  value = data.ibm_tg_gateway.project
}


# output "region_info" {
#   value = data.ibm_is_region.mzr
# }

output "zones" {
  value = data.ibm_is_zones.mzr
}

output "schematics_location" {
  value = lookup(data.external.env.result, "TF_VAR_SCHEMATICSLOCATION", "")
}

output "schematics_ssh_access_ips" {
  value = local.schematics_ssh_access
}


