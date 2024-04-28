# Configure the AWS provider
provider "aws" {
  region = "us-east-1"
}
# Create VPC resources using the module
module "vpc" {
  source = "./modules/vpc"
  vpc_name                = var.vpc_name
  vpc_cidr                = var.vpc_cidr
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  availability_zones      = var.availability_zones

}

# Include EKS module
#module "eks" {
#  source = "./modules/eks"

#  cluster_name                = var.cluster_name
#  public_subnet_cidr_blocks   = module.vpc.public_subnet_cidr_blocks
#  private_subnet_cidr_blocks  = module.vpc.private_subnet_cidr_blocks
#  availability_zones          = module.vpc.availability_zones
#  vpc_id                      = module.vpc.vpc_id
#}

# Create ECR Repository
resource "aws_ecr_repository" "nodejs_app" {
  name = "nodejs-app"
}


