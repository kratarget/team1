resource "aws_eks_cluster" "eks" {
  name = local.cluster_name

  access_config {
    authentication_mode = "API"
  }

  role_arn = data.aws_iam_role.cluster.arn
  version  = var.cluster_version

  bootstrap_self_managed_addons = false

  compute_config {
    enabled       = true
    node_pools    = ["general-purpose", "system"]
    node_role_arn = data.aws_iam_role.node.arn
  }

  kubernetes_network_config {
    elastic_load_balancing {
      enabled = true
    }
  }

  storage_config {
    block_storage {
      enabled = true
    }
  }

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true

    subnet_ids = var.subnet_ids
  }

  # Ensure that IAM Role permissions are created before and deleted
  # after EKS Cluster handling. Otherwise, EKS will not be able to
  # properly delete EKS managed EC2 infrastructure such as Security Groups.
  # depends_on = [
  #   aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  #   aws_iam_role_policy_attachment.cluster_AmazonEKSComputePolicy,
  #   aws_iam_role_policy_attachment.cluster_AmazonEKSBlockStoragePolicy,
  #   aws_iam_role_policy_attachment.cluster_AmazonEKSLoadBalancingPolicy,
  #   aws_iam_role_policy_attachment.cluster_AmazonEKSNetworkingPolicy,
  # ]
}




# ---
# Roles are centrally managed, imported instead of created.
# resource "aws_iam_role" "node" {
#   name = "eks-auto-node-role" # local.iam_role_node
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = ["sts:AssumeRole"]
#         Effect = "Allow"
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       },
#     ]
#   })
# }
#
# resource "aws_iam_role_policy_attachment" "node_AmazonEKSWorkerNodeMinimalPolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodeMinimalPolicy"
#   role       = aws_iam_role.node.name
# }
#
# resource "aws_iam_role_policy_attachment" "node_AmazonEC2ContainerRegistryPullOnly" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"
#   role       = aws_iam_role.node.name
# }
#
# resource "aws_iam_role" "cluster" {
#   name = "eks-cluster-role" # local.iam_role_cluster
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = [
#           "sts:AssumeRole",
#           "sts:TagSession"
#         ]
#         Effect = "Allow"
#         Principal = {
#           Service = "eks.amazonaws.com"
#         }
#       },
#     ]
#   })
# }
#
# resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role       = aws_iam_role.cluster.name
# }
#
# resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSComputePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSComputePolicy"
#   role       = aws_iam_role.cluster.name
# }
#
# resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSBlockStoragePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSBlockStoragePolicy"
#   role       = aws_iam_role.cluster.name
# }
#
# resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSLoadBalancingPolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSLoadBalancingPolicy"
#   role       = aws_iam_role.cluster.name
# }
#
# resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSNetworkingPolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSNetworkingPolicy"
#   role       = aws_iam_role.cluster.name
# }