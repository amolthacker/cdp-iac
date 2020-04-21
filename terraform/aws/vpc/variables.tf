variable "aws_access_key_id" {
  description = "AWS account Access Key ID"
}

variable "aws_secret_access_key" {
  description = "AWS account Access Key Secret"
}

variable "aws_region" {
  description = "AWS Region"
}

variable "my_public_ip" {
  description = "Public IP address of the local network"
}

variable "vpc_id" {
  description = "AWS VPC id"
  default     = ""
}

variable "cidr_block_1" {
  description = "CIDR for subnet 1"
  default     = "10.0.1.0/24"
}

variable "owner" {
  description = "Owner user name"
}

variable "prefix" {
  description = "Prefix for AWS resources"
}

variable "project" {
  description = "Project name"
}