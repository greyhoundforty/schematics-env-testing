locals {
  time   = formatdate("DDhhmm", timestamp())
  region = lookup(data.external.env.result, "TF_VAR_SCHEMATICSLOCATION", "")
  geo    = substr(local.region, 0, 2)
  schematics_ssh_access_map = {
    us = ["169.61.99.176/28", "169.62.1.224/28", "169.63.150.144/28", "169.63.173.208/28", "169.47.104.160/28", "169.60.172.144/28", "169.63.254.64/28"],
    eu = ["158.175.90.16/28", "158.175.138.176/28", "141.125.79.160/28", "158.176.134.80/28", "158.177.210.176/28", "158.177.216.144/28", "161.156.138.80/28", "149.81.135.64/28"]
  }
  schematics_ssh_access = lookup(local.schematics_ssh_access_map, local.geo, ["0.0.0.0/0"])
}


resource "local_file" "vpc" {
  content = <<EOF
    [${jsonencode(data.ibm_is_vpc.project)},${jsonencode(data.ibm_is_region.mzr)}]

    EOF 

  filename = "${path.module}/${local.time}-vpc-details.json"
}

resource "ibm_cos_bucket_object" "mzr_file" {
  depends_on      = [local_file.vpc]
  bucket_crn      = data.ibm_cos_bucket.south.crn
  bucket_location = data.ibm_cos_bucket.south.region_location
  content         = <<EOF
  ${jsonencode(data.ibm_is_region.mzr)}

    EOF 

  key = "${local.time}-mzr-details.json"
}

resource "ibm_cos_bucket_object" "vpc_file" {
  depends_on      = [ibm_cos_bucket_object.mzr_file]
  bucket_crn      = data.ibm_cos_bucket.south.crn
  bucket_location = data.ibm_cos_bucket.south.region_location
  content_file    = "${path.module}/${local.time}-vpc-details.json"

  key = "${local.time}-vpc-details.json"
}

resource "ibm_cos_bucket_object" "count_test" {
  count           = length(data.ibm_is_vpc.project.subnets)
  bucket_crn      = data.ibm_cos_bucket.south.crn
  bucket_location = data.ibm_cos_bucket.south.region_location
  content         = <<EOF
  things
    EOF 

  key = "${local.time}-${count.index+1}-details.json"
}

# resource ibm_is_flow_log test_flowlog {
#   count = length(data.ibm_is_vpc.subnets)
#   name = "test-instance-flow-log"
#   target = ibm_is_instance.testacc_instance.id
#   active = true
#   storage_bucket = ibm_cos_bucket.bucket1.bucket_name
# }