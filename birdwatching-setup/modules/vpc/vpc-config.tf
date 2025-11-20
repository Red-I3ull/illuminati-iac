data "aws_vpc" "account-vpc" {
  id = var.vpc-id
}

data "aws_internet_gateway" "igw" {
  internet_gateway_id = var.internet_gateway_id
}

resource "aws_route_table" "public-route-table" {
  vpc_id = data.aws_vpc.account-vpc.id
  tags = merge(var.common_tags, {
    Name    = "public-route-table-${var.env}"
    Project = "Birdwatching"
  })
}

resource "aws_route" "public-route" {
  route_table_id         = aws_route_table.public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = data.aws_internet_gateway.igw.id
}

resource "aws_eip" "nat-eip" {
  tags = merge(var.common_tags, {
    Name    = "nat-eip-${var.env}"
    Project = "Birdwatching"
  })
}

resource "aws_route_table" "private-route-table" {
  vpc_id = data.aws_vpc.account-vpc.id
  tags = merge(var.common_tags, {
    Name    = "private-route-table-${var.env}"
    Project = "Birdwatching"
  })
}

