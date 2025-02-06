# IAM Role (example: AWS SSO Role for Admin Access)
resource "aws_eks_access_entry" "eks_admin_access" {
  cluster_name  = aws_eks_cluster.eks.name
  principal_arn = "arn:aws:iam::833935676990:role/aws-reserved/sso.amazonaws.com/eu-west-1/AWSReservedSSO_AdministratorAccess_8adb6991ac24e187"

  type = "STANDARD"
}

# Associate Access Policy
resource "aws_eks_access_policy_association" "eks_admin_policy_association" {
  cluster_name  = aws_eks_cluster.eks.name
  principal_arn = aws_eks_access_entry.eks_admin_access.principal_arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}

resource "aws_eks_access_entry" "eks_cluster_insights" {
  cluster_name  = aws_eks_cluster.eks.name
  principal_arn = "arn:aws:iam::180374238106:role/AmazonEKSClusterInsightsViewOnlyRole"
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "eks_cluster_insights_policy" {
  cluster_name  = aws_eks_cluster.eks.name
  principal_arn = aws_eks_access_entry.eks_cluster_insights.principal_arn
  policy_arn    = "arn:aws:iam::aws:policy/AmazonEKSClusterInsightsViewPolicy"

  access_scope {
    type = "cluster"
  }
}
