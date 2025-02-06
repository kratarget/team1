locals {
  cluster_name = "ms-${local.environment_short[var.environment]}-eks-${var.app_name}-${local.location_short[data.aws_region.current.name]}"

  location_short = {
    "eu-west-1"    = "we1"
    "eu-west-2"    = "we2"
    "eu-west-3"    = "we3"
    "eu-central-1" = "ce1"
  }

  environment_short = {
    production    = "prd"
    hub           = "hub"
    nonproduction = "nonprd"
    acceptance    = "acc"
    integration   = "int"
    development   = "dev"
  }

}
