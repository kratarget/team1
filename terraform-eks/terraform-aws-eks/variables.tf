# variable "cluster_name" {
#     description = "The name of the EKS cluster"
#     type        = string
#
#     validation {
#     condition     = can(regex("^[0-9A-Za-z][A-Za-z0-9\\-_]{0,99}$", var.cluster_name))
#     error_message = "The cluster_name must be between 1-100 characters, start with an alphanumeric character, and only contain alphanumerics, dashes, and underscores."
#   }
# }

variable "cluster_version" {
  description = "The kubernetes version of the cluster"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs to use for the EKS cluster."
  type        = list(string)

  # Ensure at least 2 subnets are provided
  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "At least two subnet IDs are required."
  }
}

variable "environment" {
  type = string
}

variable "app_name" {
  type = string
}

variable "cluster_role" {
  type    = string
  default = null

}

variable "node_role" {
  type    = string
  default = null

}

