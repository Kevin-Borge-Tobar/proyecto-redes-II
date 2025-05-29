# ---------------------------------
# Outputs Sucursal España
# ---------------------------------
output "vpc_id_sucursal_espana" {
  value = aws_vpc.sucursal_espana.id
}

output "sucursal_espana_gerencia_subnet_id" {
  value = aws_subnet.sucursal_espana_gerencia.id
}
output "sucursal_espana_rh_subnet_id" {
  value = aws_subnet.sucursal_espana_rh.id
}
output "sucursal_espana_informatica_subnet_id" {
  value = aws_subnet.sucursal_espana_informatica.id
}
output "sucursal_espana_contabilidad_subnet_id" {
  value = aws_subnet.sucursal_espana_contabilidad.id
}
output "sucursal_espana_ventas_subnet_id" {
  value = aws_subnet.sucursal_espana_ventas.id
}
output "sucursal_espana_perifericos_subnet_id" {
  value = aws_subnet.sucursal_espana_perifericos.id
}

output "sucursal_espana_informatica_ec2_private_ip" {
  value = aws_instance.sucursal_espana_informatica_ec2.private_ip
}
