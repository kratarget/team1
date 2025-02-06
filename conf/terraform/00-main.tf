terraform {
  # A chaque montée de version modifier le tag 'technical:terraform:required_version' en bas de ce fichier !
  required_version = "1.10.1"
  required_providers {
    # A chaque montée de version modifier le tag 'technical:provider:aws:required_version' en bas de ce fichier !
    aws = {
      source  = "hashicorp/aws"
      version = "5.80.0"
    }
    sql = {
      source  = "terraform-providers/mysql"
      version = "1.9.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
}

#---------------------------------------------------------------------------------------------------
# Récupération des accés AWS du compte 'var.account_environment_for_deployment'.
#---------------------------------------------------------------------------------------------------
provider "aws" {
  profile = "cicd-monitoring"
  region  = local.region
  assume_role {
    role_arn = data.terraform_remote_state.principal-sts.outputs.role_arn
  }
}

#---------------------------------------------------------------------------------------------------
# Récupération des accés AWS du compte 'var.account_environment_for_deployment'.
#---------------------------------------------------------------------------------------------------
provider "aws" {
  alias   = "principal"
  profile = "cicd-monitoring"
  region  = local.region
  assume_role {
    role_arn = data.terraform_remote_state.principal-sts.outputs.role_arn
  }
}

#---------------------------------------------------------------------------------------------------
# Initialisation du backend distant
# https://gitlab.aws.dmpa-noprod.myengie.com/b2c/transverse/team/landing-zone/cicd-monitoring/terraform-s3-remote-backend
#---------------------------------------------------------------------------------------------------
terraform {
  backend "s3" {
    profile = "cicd-monitoring"
    region  = "eu-west-1"
    bucket  = "dgp-inf-cor-ter-prd-tfs"
    key     = "landing-zone/oneretail/hackathon/team1.tfstate"
  }
}


#---------------------------------------------------------------------------------------------------
# Synthétisation des variables.
#---------------------------------------------------------------------------------------------------
locals {

  region = "eu-west-1"

  ecr_name                   = "kratarget/team1/team1-app"
  container_name             = "team1-app"

  environment = [
    {
      "name"  : "ENVIRONMENT_NAME"
      "value" : var.environment
    },
  ]
}
