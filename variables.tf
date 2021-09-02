variable "region" {
  type        = string
  description = "IBM VPC region where resources are located."
  default     = ""
}

variable "resource_group" {
  type        = string
  description = "Resource Group to use for all resources"
  default     = ""
}

variable "transit_gateway" {
  type        = string
  description = "Name of existing TGW to use as data source."
  default     = ""
}

variable "vpc_name" {
  type        = string
  description = "Name of existing VPC to use as data source"
  default     = ""
}