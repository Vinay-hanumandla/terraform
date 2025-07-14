module "vpc" {
  source = "./modules/vpc"

  cidr_block = "10.0.0.0/16"

}

module "ec2" {
  source         = "./modules/ec2"
  dev-pub-sub-id = module.vpc.dev-pub-sub-id
  vpc-id         = module.vpc.vpc-id
  key_pair_name  = "eks-project-key"
}
