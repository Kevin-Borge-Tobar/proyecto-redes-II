# ---------------------------------
# Outputs Sucursal 1
# ---------------------------------
output "vpc_id_sucursal_1" {
  value = aws_vpc.sucursal_1.id
}

output "sucursal_1_gerencia_subnet_id" {
  value = aws_subnet.sucursal_1_gerencia.id
}
output "sucursal_1_rh_subnet_id" {
  value = aws_subnet.sucursal_1_rh.id
}
output "sucursal_1_informatica_subnet_id" {
  value = aws_subnet.sucursal_1_informatica.id
}
output "sucursal_1_contabilidad_subnet_id" {
  value = aws_subnet.sucursal_1_contabilidad.id
}
output "sucursal_1_ventas_subnet_id" {
  value = aws_subnet.sucursal_1_ventas.id
}
output "sucursal_1_perifericos_subnet_id" {
  value = aws_subnet.sucursal_1_perifericos.id
}

output "sucursal_1_informatica_ec2_private_ip" {
  value = aws_instance.sucursal_1_informatica_ec2.private_ip
}
