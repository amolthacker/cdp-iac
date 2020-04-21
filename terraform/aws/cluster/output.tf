output "instance_state" {
    value = aws_instance.cdp_cluster[0].instance_state
}

output "public_ip" {
    value = aws_instance.cdp_cluster[0].public_ip
}

output "public_dns" {
    value = aws_instance.cdp_cluster[0].public_dns
}

output "private_ip" {
    value = aws_instance.cdp_cluster[0].private_ip
}

output "private_dns" {
    value = aws_instance.cdp_cluster[0].private_dns
}