module "terraform-aws-eks" {
  source = "./terraform-aws-eks"
  providers = {
    aws = aws
  }

  app_name        = "team1-terraform"
  environment     = "development"
  cluster_version = "1.31"
  subnet_ids = [
    "subnet-02d7fe499e716ba1c",
    "subnet-0ad66248d4ac0abb3"
  ]
}
