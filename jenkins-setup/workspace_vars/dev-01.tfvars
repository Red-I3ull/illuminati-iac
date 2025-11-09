env               = "dev-01"
vpc-id            = "" #pass existing value
region            = "us-east-1"
availability-zone = "us-east-1a"

private-subnets-for-jenkins    = "10.0.2.0/24"
instance-type                  = "t3.micro"
ami                            = "ami-0341d95f75f311023"

dev_deployment_role_arn = "arn:aws:iam::455185968385:role/stage-01-jenkins-deployment-role"
prod_deployment_role_arn = "arn:aws:iam::455185968385:role/stage-01-jenkins-deployment-role"