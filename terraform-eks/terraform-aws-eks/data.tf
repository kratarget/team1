data "aws_region" "current" {}

data "aws_iam_role" "cluster" {
  name = coalesce(var.cluster_role, "AmazonEKSAutoClusterRole-Default")
}

data "aws_iam_role" "node" {
  name = coalesce(var.node_role, "AmazonEKSAutoNodeRole-Default")
}

