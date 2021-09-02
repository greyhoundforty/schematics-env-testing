resource "local_file" "details" {
  content = <<EOF
    ${jsonencode(data.ibm_is_vpc.project, data.ibm_is_region.mzr)},
    ${jsonencode(data.ibm_is_region.mzr)}

    EOF 

  filename = "${path.module}/details.json"
}

resource "ibm_cos_bucket_object" "file" {
  depends_on      = [local_file.details]
  bucket_crn      = data.ibm_cos_bucket.south.crn
  bucket_location = data.ibm_cos_bucket.south.region_location
  content_file    = "${path.module}/details.json"
  key             = "details.json"
}