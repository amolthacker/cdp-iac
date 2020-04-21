variable "aws_access_key_id" {
  description = "AWS account Access Key ID"
}

variable "aws_secret_access_key" {
  description = "AWS account Access Key Secret"
}

variable "aws_region" {
  description = "AWS Region"
}

variable "ssh_key_name" {
  description = "Name of the SSH Key in AWS"
}

variable "my_public_ip" {
  description = "Public IP address of the local network"
}

variable "vpc_id" {
  description = "AWS VPC id"
}

variable "instance_ami" {
  description = "AWS AMI for the CDP cluster"
}

variable "instance_type" {
  description = "Instance type for the CDP cluster"
}

variable "cluster_size" {
  description = "No.of nodes in CDP Cluster"
  default     = 1
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

variable "enddate" {
  description = "Resource expiration date (MMDDYYYY)"
}