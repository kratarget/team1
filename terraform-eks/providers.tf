variable "AWS_REGION" { default = "eu-west-1" }
variable "AWS_ACCESS_KEY" { default = null }
variable "AWS_SECRET_KEY" { default = null }
variable "AWS_PROFILE" { default = null }

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.0.0,<6.0.0"
    }
  }
}

provider "aws" {
  profile    = var.AWS_PROFILE
  region     = var.AWS_REGION
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}

resource "aws_ssm_parameter" "dummy" {
  name  = "/hackathon/dummy"
  type  = "String"
  value = "dummy"
}
