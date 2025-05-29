# ID de la VPC Central
# Los outputs se  para mostrar información importante dentro de la infraestructura creada con Terraform.
output "vpc_id" {
  value = aws_vpc.sede_central.id
}

# IDs de las subredes por departamento y pública
output "public_subnet_id" {
  value = aws_subnet.public_subnet_central.id
}
output "gerencia_subnet_id" {
  value = aws_subnet.gerencia.id
}
output "rh_subnet_id" {
  value = aws_subnet.rh.id
}
output "informatica_subnet_id" {
  value = aws_subnet.informatica.id
}
output "contabilidad_subnet_id" {
  value = aws_subnet.contabilidad.id
}
output "ventas_subnet_id" {
  value = aws_subnet.ventas.id
}
output "perifericos_subnet_id" {
  value = aws_subnet.perifericos.id
}

# IP pública del servidor público (para acceso desde navegador)
output "public_server_public_ip" {
  value = aws_instance.public_server.public_ip
}

# IP privada y pública de cada instancia EC2 privada (por si las necesitas para pruebas internas)
output "gerencia_ec2_private_ip" {
  value = aws_instance.gerencia_ec2.private_ip
}
output "rh_ec2_private_ip" {
  value = aws_instance.rh_ec2.private_ip
}
output "informatica_ec2_private_ip" {
  value = aws_instance.informatica_ec2.private_ip
}
output "contabilidad_ec2_private_ip" {
  value = aws_instance.contabilidad_ec2.private_ip
}
output "ventas_ec2_private_ip" {
  value = aws_instance.ventas_ec2.private_ip
}
output "perifericos_ec2_private_ip" {
  value = aws_instance.perifericos_ec2.private_ip
}

# Si deseas mostrar también la IP pública (aunque normalmente solo la tiene la pública)
output "gerencia_ec2_public_ip" {
  value = aws_instance.gerencia_ec2.public_ip
  description = "Probablemente vacío si la instancia no tiene IP pública."
}