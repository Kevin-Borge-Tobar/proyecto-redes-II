# ---------------------------------
# Outputs Sucursal 2
# ---------------------------------
output "vpc_id_sucursal_2" {
  value = aws_vpc.sucursal_2.id
}

output "sucursal_2_gerencia_subnet_id" {
  value = aws_subnet.sucursal_2_gerencia.id
}
output "sucursal_2_rh_subnet_id" {
  value = aws_subnet.sucursal_2_rh.id
}
output "sucursal_2_informatica_subnet_id" {
  value = aws_subnet.sucursal_2_informatica.id
}
output "sucursal_2_contabilidad_subnet_id" {
  value = aws_subnet.sucursal_2_contabilidad.id
}
output "sucursal_2_ventas_subnet_id" {
  value = aws_subnet.sucursal_2_ventas.id
}
output "sucursal_2_perifericos_subnet_id" {
  value = aws_subnet.sucursal_2_perifericos.id
}

output "sucursal_2_informatica_ec2_private_ip" {
  value = aws_instance.sucursal_2_informatica_ec2.private_ip
}
