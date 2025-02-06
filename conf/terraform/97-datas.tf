#---------------------------------------------------------------------------------------------------
# Récupération des outputs du projet de création du role STS du compte 'var.account_name_for_deployment'
#---------------------------------------------------------------------------------------------------
data "terraform_remote_state" "principal-sts" {
  backend = "s3"
  config = {
    bucket  = "dgp-inf-cor-ter-prd-tfs"
    key     = "env:/${var.account_environment_for_deployment}/landing-zone/${var.account_name_for_deployment}/assume-role-for-cicd-monitoring.tfstate"
    profile = "cicd-monitoring"
    region  = "eu-west-1"
  }
}

#---------------------------------------------------------------------------------------------------
# Récupération des outputs du projet de création de l'infra du compte 'var.account_name_for_deployment'
#---------------------------------------------------------------------------------------------------
data "terraform_remote_state" "principal-infra" {
  backend = "s3"
  config = {
    bucket  = "dgp-inf-cor-ter-prd-tfs"
    key     = "env:/${var.account_environment_for_deployment}/landing-zone/${var.account_name_for_deployment}/infra.tfstate"
    profile = "cicd-monitoring"
    region  = "eu-west-1"
  }
}
