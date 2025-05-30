output "central_instance_private_ip" {
  description = "IP privada de la instancia en sede central"
  value       = aws_instance.central_ec2.private_ip
}

output "central_instance_public_ip" {
  description = "IP pública de la instancia en sede central"
  value       = aws_instance.central_ec2.public_ip
}

output "central_vpc_id" {
  description = "VPC ID de la sede central"
  value       = aws_vpc.sede_central.id
}



output "vpc_peering_connection_id" {
  description = "ID de la conexión de peering entre central y sucursal 1"
  value       = aws_vpc_peering_connection.central_to_sucursal_1.id
}

