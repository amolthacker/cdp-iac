terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  version    = "~> 2.43"
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  region     = var.aws_region
}

data "aws_subnet" "subnet" {
  vpc_id = "${var.vpc_id}"

  filter {
    name   = "tag:Name"
    values = ["${var.prefix}-subnet1"]
  }
}

data "aws_security_group" "sg" {
  vpc_id = "${var.vpc_id}"

  filter {
    name   = "tag:Name"
    values = ["${var.prefix}-sg"]
  }
}

data "aws_route_table" "rtb" {
  vpc_id = "${var.vpc_id}"

  filter {
    name   = "tag:Name"
    values = ["${var.prefix}-rtb"]
  }
}

locals {
  rtbassoc_id = "${data.aws_route_table.rtb.associations.*.route_table_association_id[0]}"
}


resource "aws_instance" "cdp_cluster" {
  ami                    = "${var.instance_ami}"
  instance_type          = "${var.instance_type}"
  count                  = "${var.cluster_size}"
  availability_zone      = "${var.aws_region}a"
  key_name               = "${var.ssh_key_name}"
  subnet_id              = "${data.aws_subnet.subnet.id}"
  vpc_security_group_ids = ["${data.aws_security_group.sg.id}"]

  depends_on = [
    local.rtbassoc_id,
  ]

  timeouts {
    create = "10m"
  }

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "100"
    delete_on_termination = true
  }

  ebs_block_device {
    device_name           = "/dev/sdc"
    volume_type           = "gp2"
    volume_size           = "200"
  }

  tags = {
    Name    = "${var.prefix}-cdp"
    owner   = var.owner
    project = var.project
    enddate = var.enddate
  }
  
}

resource "aws_security_group_rule" "allow_cdsw_healthcheck" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [ for ip in aws_instance.cdp_cluster.*.public_ip: "${ip}/32" ]
  security_group_id = "${data.aws_security_group.sg.id}"
}

