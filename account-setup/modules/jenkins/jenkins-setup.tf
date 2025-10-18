resource "tls_private_key" "sskeygen-execution" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "jenkins-key-pair" {
  depends_on = [tls_private_key.sskeygen-execution]
  key_name   = "jenkins-public"
  public_key = tls_private_key.sskeygen-execution.public_key_openssh
}

resource "aws_subnet" "private-subnet-jenkins" {
  vpc_id            = var.vpc-id
  cidr_block        = var.private-subnets-for-jenkins
  availability_zone = var.availability-zone
  tags = merge(var.common_tags, {
    Name = "private-${var.availability-zone}-jenkins"
  })
}

resource "aws_iam_role" "jenkins-role" {
  name = "jenkins-role-${var.env}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "jenkins-ssm" {
  role       = aws_iam_role.jenkins-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_instance_profile" "jenkins-profile" {
  name = "jenkins-profile"
  role = aws_iam_role.jenkins-role.name
}

resource "aws_security_group" "jenkins-security-group" {
  name = "allow-all"

  vpc_id = var.vpc-id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "jenkins-instance" {
  ami                    = var.ami
  instance_type          = "c7i-flex.large"
  subnet_id              = aws_subnet.private-subnet-jenkins.id
  vpc_security_group_ids = [aws_security_group.jenkins-security-group.id]
  iam_instance_profile   = aws_iam_instance_profile.jenkins-profile.name

  key_name = aws_key_pair.jenkins-key-pair.key_name

  tags = merge(var.common_tags, {
    Name = "jenkins-instance"
  })

}

resource "aws_ebs_volume" "jenkins-volume" {
  availability_zone = var.availability-zone
  size              = 1
  type              = "gp3"
  tags = merge(var.common_tags, {
    Name = "jenkins-volume"
  })
}

resource "aws_volume_attachment" "jenkins-volume-attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.jenkins-volume.id
  instance_id = aws_instance.jenkins-instance.id
}
