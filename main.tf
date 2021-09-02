locals {
  time = formatdate("DDhhmm", timestamp())
}


resource "local_file" "vpc" {
  content = <<EOF
    ${jsonencode(data.ibm_is_vpc.project)}

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