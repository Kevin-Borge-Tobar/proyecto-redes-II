# ID de la VPC de la sede central
output "vpc_id_sede_central" {
  value = aws_vpc.sede_central.id
}

# Subredes públicas en la sede central (AZ1 y AZ2)
output "public_subnet_central_az1_id" {
  value = aws_subnet.public_subnet_central_az1.id
}
output "public_subnet_central_az2_id" {
  value = aws_subnet.public_subnet_central_az2.id
}

# Subredes de gerencia en la sede central (AZ1 y AZ2)
output "gerencia_subnet_az1_id" {
  value = aws_subnet.gerencia_az1.id
}
output "gerencia_subnet_az2_id" {
  value = aws_subnet.gerencia_az2.id
}

# Tabla de rutas privadas de la sede central
output "central_private_rt_id" {
  value = aws_route_table.central_private_rt.id
}

# Ruta hacia la sucursal 1 desde la sede central
output "central_to_sucursal_1_route_id" {
  value = aws_route.central_to_sucursal_1.id
}

# Conexión de peering entre la sucursal 1 y la sede central
output "sucursal_1_to_central_peering_id" {
  value = aws_vpc_peering_connection.sucursal_1_to_central.id
}

# IP privada de las instancias EC2 de gerencia en la sede central (AZ1 y AZ2)
output "gerencia_ec2_az1_private_ip" {
  value = aws_instance.gerencia_ec2_az1.private_ip
}
output "gerencia_ec2_az2_private_ip" {
  value = aws_instance.gerencia_ec2_az2.private_ip
}
