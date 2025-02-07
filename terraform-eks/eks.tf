module "eks" {
  source  = "tfe.azure.bnl-ms.myengie.com/OneRetail_Hackaton/eks/aws"
  version = "0.0.1"

  cluster_name    = "team1-eks-seahorse"
  cluster_version = "1.31"

  bootstrap_self_managed_addons = true
  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  # Dummy push to trigger deploy

  # Optional
  cluster_endpoint_public_access = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  vpc_id                   = "vpc-0c8c9fbe001e6d3b2"
  subnet_ids               = ["subnet-02d7fe499e716ba1c", "subnet-0ad66248d4ac0abb3"]
  #control_plane_subnet_ids = [""]

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
  }

  eks_managed_node_groups = {
    hackathon-team-octopus = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2_x86_64"
      instance_types = ["m6i.large"]

      min_size     = 2
      max_size     = 10
      desired_size = 2
    }
  }

  access_entries = {
    "LabAdministrator" = {
      principal_arn      = "arn:aws:iam::419387516581:role/aws-reserved/sso.amazonaws.com/eu-west-1/AWSReservedSSO_AdministratorAccess_1620459eec5499a0"
      username           = "arn:aws:iam::419387516581:role/AWSReservedSSO_AdministratorAccess_1620459eec5499a0/{{SessionName}}"
      policy_associations = {
        clusteradmin = {
          policy_arn   = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        },
        admin = {
          policy_arn   = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"
          access_scope = {
            type = "cluster"
          }

        }
      }
    }
  }


  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
