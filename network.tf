#--------------------|
#--------DATA--------|
#--------------------|
data "aws_availability_zones" "available" {}

#--------------------|
#-----NETWORKING-----|
#--------------------|
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_blocks[0]
  enable_dns_hostnames = true
    tags = merge(local.COMMON_TAGS, {
    Name = "${local.NAME_PREFIX_DEV}-vpc"
  })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(local.COMMON_TAGS, {
    Name = "${local.NAME_PREFIX_DEV}-igw"
  })
}

resource "aws_subnet" "subnets" {
  count                   = var.VPC_SUBNET_COUNT
  cidr_block              = cidrsubnet(var.VPC_CIDR_BLOCK, 8, count.index)
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags = merge(local.COMMON_TAGS, {
    Name = "${local.NAME_PREFIX_DEV}-subnet-${count.index}"
  })
}

#--------------------|
#-------ROUTING------|
#--------------------|

resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.COMMON_TAGS, {
    Name = "${local.NAME_PREFIX_DEV}-rtb"
  })
}

resource "aws_route_table_association" "rta-subnets" {
  count          = var.VPC_SUBNET_COUNT
  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.rtb.id
}
