resource "aws_iam_role" "jenkins_deployment" {
  name = "${var.env}-jenkins-deployment-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.jenkins_account_id}:root" # acount id where jenkins be deployed 
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "${var.env}-jenkins-deployment-role"
    Environment = var.env
  }
}

resource "aws_iam_role_policy" "jenkins_deployment" {
  name = "jenkins-deployment-policy"
  role = aws_iam_role.jenkins_deployment.id

  policy = file("./modules/iam/jenkins-policy.json")
}


resource "aws_iam_role" "photo-saving-role" {
  name = "photosaver-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "photosaver_ssm" {
  role       = aws_iam_role.photo-saving-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_instance_profile" "photo-saving-profile" {
  name = "photosaver-profile"
  role = aws_iam_role.photo-saving-role.name
}
