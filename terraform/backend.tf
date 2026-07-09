terraform {
  backend "s3" {
    bucket       = "hassan-eks-terraform-state-2026"
    key          = "eks/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

