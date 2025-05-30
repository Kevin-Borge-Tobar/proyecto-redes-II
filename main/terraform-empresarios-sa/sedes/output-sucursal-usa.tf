# ---------------------------------
# Outputs Sucursal USA (Multi-AZ)
# ---------------------------------

output "vpc_id_sucursal_usa" {
  value = aws_vpc.sucursal_usa.id
}

output "sucursal_usa_gerencia_subnet_az1_id" {
  value = aws_subnet.sucursal_usa_gerencia_az1.id
}
output "sucursal_usa_gerencia_subnet_az2_id" {
  value = aws_subnet.sucursal_usa_gerencia_az2.id
}

# output "sucursal_usa_rh_subnet_az1_id" {
#   value = aws_subnet.sucursal_usa_rh_az1.id
# }
# output "sucursal_usa_rh_subnet_az2_id" {
#   value = aws_subnet.sucursal_usa_rh_az2.id
# }
#
# output "sucursal_usa_informatica_subnet_az1_id" {
#   value = aws_subnet.sucursal_usa_informatica_az1.id
# }
# output "sucursal_usa_informatica_subnet_az2_id" {
#   value = aws_subnet.sucursal_usa_informatica_az2.id
# }
#
# output "sucursal_usa_contabilidad_subnet_az1_id" {
#   value = aws_subnet.sucursal_usa_contabilidad_az1.id
# }
# output "sucursal_usa_contabilidad_subnet_az2_id" {
#   value = aws_subnet.sucursal_usa_contabilidad_az2.id
# }
#
# output "sucursal_usa_ventas_subnet_az1_id" {
#   value = aws_subnet.sucursal_usa_ventas_az1.id
# }
# output "sucursal_usa_ventas_subnet_az2_id" {
#   value = aws_subnet.sucursal_usa_ventas_az2.id
# }
#
# output "sucursal_usa_perifericos_subnet_az1_id" {
#   value = aws_subnet.sucursal_usa_perifericos_az1.id
# }
# output "sucursal_usa_perifericos_subnet_az2_id" {
#   value = aws_subnet.sucursal_usa_perifericos_az2.id
# }
#
# output "sucursal_usa_informatica_ec2_az1_private_ip" {
#   value = aws_instance.sucursal_usa_informatica_ec2_az1.private_ip
# }
# output "sucursal_usa_informatica_ec2_az2_private_ip" {
#   value = aws_instance.sucursal_usa_informatica_ec2_az2.private_ip
# }

