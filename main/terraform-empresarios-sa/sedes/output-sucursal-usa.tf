# ---------------------------------
# Outputs Sucursal USA
# ---------------------------------
output "vpc_id_sucursal_usa" {
  value = aws_vpc.sucursal_usa.id
}

output "sucursal_usa_gerencia_subnet_id" {
  value = aws_subnet.sucursal_usa_gerencia.id
}
output "sucursal_usa_rh_subnet_id" {
  value = aws_subnet.sucursal_usa_rh.id
}
output "sucursal_usa_informatica_subnet_id" {
  value = aws_subnet.sucursal_usa_informatica.id
}
output "sucursal_usa_contabilidad_subnet_id" {
  value = aws_subnet.sucursal_usa_contabilidad.id
}
output "sucursal_usa_ventas_subnet_id" {
  value = aws_subnet.sucursal_usa_ventas.id
}
output "sucursal_usa_perifericos_subnet_id" {
  value = aws_subnet.sucursal_usa_perifericos.id
}

output "sucursal_usa_informatica_ec2_private_ip" {
  value = aws_instance.sucursal_usa_informatica_ec2.private_ip
}
