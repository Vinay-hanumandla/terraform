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


module "eks" {
  source = "./modules/eks"

  cluster_name       = "dev-eks-cluster"
  private_subnet_ids = [module.vpc.dev-pvt-sub-1-id, module.vpc.dev-pvt-sub-2-id]
  k8s_version        = "1.33"
}


module "node_group" {
  source             = "./modules/eks-node-group"
  cluster_name       = module.eks.cluster_name
  node_group_name    = "dev-node-group"
  private_subnet_ids = [module.vpc.dev-pvt-sub-1-id, module.vpc.dev-pvt-sub-2-id]
  node_sg_id         = module.sg.eks_nodes_sg_id
  ssh_key_name       = "eks-project-key"
}


module "efs" {
  source       = "./modules/efs"
  name         = "dev-efs"
  vpc_id       = module.vpc.vpc-id
  #subnet_ids   = [module.vpc.dev-pvt-sub-1-id, module.vpc.dev-pvt-sub-2-id]
  subnet_ids = {
    subnet-1 = module.vpc.dev-pvt-sub-1-id
    subnet-2 = module.vpc.dev-pvt-sub-2-id
  }

  efs_sg_id    = module.sg.efs_sg_id
}


module "sg" {
  source    = "./modules/security-groups"
  name_prefix = "dev"
  vpc_id    = module.vpc.vpc-id
}

