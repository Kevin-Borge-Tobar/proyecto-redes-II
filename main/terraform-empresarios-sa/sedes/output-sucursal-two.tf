# ---------------------------------
# Outputs Sucursal 2 (alta disponibilidad)
# ---------------------------------

output "vpc_id_sucursal_2" {
  value = aws_vpc.sucursal_2.id
}


# output "sucursal_2_gerencia_az1_subnet_id" {
#   value = aws_subnet.sucursal_2_gerencia_az1.id
# }
# output "sucursal_2_gerencia_az2_subnet_id" {
#   value = aws_subnet.sucursal_2_gerencia_az2.id
# }
#
# output "sucursal_2_rh_az1_subnet_id" {
#   value = aws_subnet.sucursal_2_rh_az1.id
# }
# output "sucursal_2_rh_az2_subnet_id" {
#   value = aws_subnet.sucursal_2_rh_az2.id
# }
#
# output "sucursal_2_informatica_az1_subnet_id" {
#   value = aws_subnet.sucursal_2_informatica_az1.id
# }
# output "sucursal_2_informatica_az2_subnet_id" {
#   value = aws_subnet.sucursal_2_informatica_az2.id
# }
#
# output "sucursal_2_contabilidad_az1_subnet_id" {
#   value = aws_subnet.sucursal_2_contabilidad_az1.id
# }
# output "sucursal_2_contabilidad_az2_subnet_id" {
#   value = aws_subnet.sucursal_2_contabilidad_az2.id
# }
#
# output "sucursal_2_ventas_az1_subnet_id" {
#   value = aws_subnet.sucursal_2_ventas_az1.id
# }
# output "sucursal_2_ventas_az2_subnet_id" {
#   value = aws_subnet.sucursal_2_ventas_az2.id
# }
#
# output "sucursal_2_perifericos_az1_subnet_id" {
#   value = aws_subnet.sucursal_2_perifericos_az1.id
# }
# output "sucursal_2_perifericos_az2_subnet_id" {
#   value = aws_subnet.sucursal_2_perifericos_az2.id
# }
#
# output "sucursal_2_informatica_ec2_az1_private_ip" {
#   value = aws_instance.sucursal_2_informatica_ec2_az1.private_ip
# }
# output "sucursal_2_informatica_ec2_az2_private_ip" {
#   value = aws_instance.sucursal_2_informatica_ec2_az2.private_ip
# }
