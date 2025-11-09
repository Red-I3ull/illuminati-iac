
module "Jenkins" {
  source                      = "./modules/jenkins"
  vpc-id                      = var.vpc-id
  private-subnets-for-jenkins = var.private-subnets-for-jenkins
  env                         = var.env
  region                      = var.region
  ami                         = var.ami
  availability-zone           = var.availability-zone
}
