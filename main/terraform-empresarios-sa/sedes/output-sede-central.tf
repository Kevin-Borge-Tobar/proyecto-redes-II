
output "central_vpc_id" {
  description = "VPC ID de la sede central"
  value       = aws_vpc.sede_central.id
}



output "vpc_peering_connection_id" {
  description = "ID de la conexión de peering entre central y sucursal 1"
  value       = aws_vpc_peering_connection.central_to_sucursal_1.id
}

