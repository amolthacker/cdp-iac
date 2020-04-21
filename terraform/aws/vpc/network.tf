terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  version    = "~> 2.43"
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  region     = var.aws_region
}

resource "aws_vpc" "vpc" {
  count                = (var.vpc_id != "" ? 0 : 1)
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "${var.prefix}-vpc"
    owner   = var.owner
    project = var.project
  }
}

resource "aws_internet_gateway" "igw" {
  count  = (var.vpc_id != "" ? 0 : 1)
  vpc_id = (var.vpc_id != "" ? var.vpc_id : aws_vpc.vpc[0].id)

  tags = {
    Name    = "${var.prefix}-igw"
    owner   = var.owner
    project = var.project
  }
}

resource "aws_route_table" "rtb" {
  count  = (var.vpc_id != "" ? 0 : 1)
  vpc_id = (var.vpc_id != "" ? var.vpc_id : aws_vpc.vpc[0].id)

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw[0].id
  }

  tags = {
    Name    = "${var.prefix}-rtb"
    owner   = var.owner
    project = var.project
  }
}

resource "aws_main_route_table_association" "rtb_assoc" {
  count          = (var.vpc_id != "" ? 0 : 1)
  vpc_id         = (var.vpc_id != "" ? var.vpc_id : aws_vpc.vpc[0].id)
  route_table_id = aws_route_table.rtb[0].id
}

resource "aws_subnet" "subnet1" {
  vpc_id                  = (var.vpc_id != "" ? var.vpc_id : aws_vpc.vpc[0].id)
  cidr_block              = "${var.cidr_block_1}"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "${var.prefix}-subnet1"
    owner   = var.owner
    project = var.project
  }
}

resource "aws_security_group" "sg" {
  name        = "${var.prefix}-sg"
  description = "Allow ingress connections from the user public IP"
  vpc_id      = (var.vpc_id != "" ? var.vpc_id : aws_vpc.vpc[0].id)

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.my_public_ip}/32"]
    self        = true
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.prefix}-sg"
    owner   = "${var.owner}"
    project = "${var.project}"
  }
}