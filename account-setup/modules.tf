module "iam" {
  source   = "./modules/iam"
  username = var.username
  region   = var.region
}

module "vpc" {
  source = "./modules/vpc"
  region = var.region
}

module "Jenkins" {
  source                      = "./modules/jenkins"
  vpc-id                      = module.vpc.vpc-id
  private-subnets-for-jenkins = var.private-subnets-for-jenkins
  env                         = var.env
  region                      = var.region
  ami                         = var.ami
  availability-zone           = var.availability-zone
}
