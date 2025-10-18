module "environment-vpc" {
  source            = "./modules/vpc/"
  vpc-id            = data.aws_vpc.account-vpc.id
  env               = var.env
  availability-zone = var.availability-zone
  region            = var.region
}
