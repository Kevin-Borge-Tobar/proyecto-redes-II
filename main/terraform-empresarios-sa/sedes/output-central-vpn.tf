output "vpn_endpoint_id" {
  value = aws_ec2_client_vpn_endpoint.empresarios_vpn.id
}

output "vpn_endpoint_dns_name" {
  value = aws_ec2_client_vpn_endpoint.empresarios_vpn.dns_name
}

output "vpn_endpoint_arn" {
  value = aws_ec2_client_vpn_endpoint.empresarios_vpn.arn
}


