variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "environment_for_rds" {
  description = "L'environnement du RDS a utiliser."
  type        = string
  default     = "dev"
}

variable "environment_for_redis" {
  description = "L'environnement du Cluster Redis a utiliser."
  type        = string
  default     = "dev"
}

variable "account_name_for_deployment" {
  description = "Nom de compte AWS de la landing Zone DGP qui sera utilisé pour déployer l'infrastructure."
  type        = string
  default     = "lab"
}

variable "account_environment_for_deployment" {
  description = "L'environnement du compte AWS de la landing Zone DGP qui sera utilisé pour déployer l'infrastructure."
  type        = string
  default     = "dev"
}


variable "vpc_id" {
  description = "ID of an existing VPC"
  type        = string
}

variable "subnet_ids" {
  description = "List of existing subnet IDs where EKS should be deployed"
  type        = list(string)
}

variable "cluster_name" {
  type    = string
  default = "team1-eks-cluster"
}

variable "github_container_registry" {
  description = "Full name of the GHCR image (e.g. ghcr.io/org/repo:tag)"
  type        = string
  default     = "ghcr.io/kratarget/team1/team1-app:latest"
}

variable "ghcr_username" {
  description = "Your GitHub username for authenticating to GHCR"
  type        = string
  sensitive   = true
  default = "kratarget"
}

variable "ghcr_token" {
  description = "A Personal Access Token (PAT) or GHCR token that can pull the image"
  type        = string
  sensitive   = true
  default = "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"
}
