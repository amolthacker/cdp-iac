output "vpc_id" {
    value = aws_vpc.vpc[0].id
}

output "subnet_id" {
    value = aws_subnet.subnet1.id
}

output "subnet_az" {
    value = aws_subnet.subnet1.availability_zone
}

output "security_group_id" {
    value = aws_security_group.sg.id
}

output "route_table_association_id" {
    value = aws_main_route_table_association.rtb_assoc[0].id
}