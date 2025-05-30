# ##############################
# # VPN EmpresariosSA - Sede Central
# ##############################
#
# resource "aws_ec2_client_vpn_endpoint" "empresarios_vpn" {
#   description            = "VPN EmpresariosSA"
#   server_certificate_arn = "arn:aws:acm:us-east-1:886436933321:certificate/f12c57d9-132d-4db1-b7d3-d14dacdb3c36"
#
#   authentication_options {
#     type                       = "certificate-authentication"
#     root_certificate_chain_arn = "arn:aws:acm:us-east-1:886436933321:certificate/f12c57d9-132d-4db1-b7d3-d14dacdb3c36"
#   }
#
#   client_cidr_block      = "172.16.0.0/22"   # NO traslapes con tu VPC
#   connection_log_options {
#     enabled = false
#   }
#   dns_servers            = ["8.8.8.8", "8.8.4.4"]
#   split_tunnel           = true
#   vpc_id                 = aws_vpc.sede_central.id
#   transport_protocol     = "udp"
#   # La asociación del security group va aquí:
#   security_group_ids     = [aws_security_group.public_sg.id]
#   tags = {
#     Name    = "EmpresariosSA-VPN"
#     Project = "RedEmpresarial2025"
#   }
# }
#
# # Asociar la VPN a las subredes públicas de alta disponibilidad
# resource "aws_ec2_client_vpn_network_association" "empresarios_vpn_az1" {
#   client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.empresarios_vpn.id
#   subnet_id              = aws_subnet.public_subnet_central_az1.id
# }
#
# resource "aws_ec2_client_vpn_network_association" "empresarios_vpn_az2" {
#   client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.empresarios_vpn.id
#   subnet_id              = aws_subnet.public_subnet_central_az2.id
# }
#
# # Regla de autorización: acceso a toda la VPC central
# resource "aws_ec2_client_vpn_authorization_rule" "empresarios_vpn_rule" {
#   client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.empresarios_vpn.id
#   target_network_cidr    = "10.0.0.0/16"       # Rango de la VPC Sede Central
#   authorize_all_groups   = true
#   description            = "Acceso a toda la VPC central"
# }
