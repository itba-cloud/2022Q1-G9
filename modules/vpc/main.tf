resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "private" {
  count = var.az_count
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(local.private_cidr, ceil(log(var.az_count, 2)), count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "private_${count.index}"
  }
}