# ---------------------------------
# Outputs Sucursal España (Multi-AZ)
# ---------------------------------

output "vpc_id_sucursal_espana" {
  value = aws_vpc.sucursal_espana.id
}

# # RH
# output "sucursal_espana_rh_subnet_az1_id" {
#   value = aws_subnet.sucursal_espana_rh_az1.id
# }
# output "sucursal_espana_rh_subnet_az2_id" {
#   value = aws_subnet.sucursal_espana_rh_az2.id
# }
#
# # Informática
# output "sucursal_espana_informatica_subnet_az1_id" {
#   value = aws_subnet.sucursal_espana_informatica_az1.id
# }
# output "sucursal_espana_informatica_subnet_az2_id" {
#   value = aws_subnet.sucursal_espana_informatica_az2.id
# }
#
# # Contabilidad
# output "sucursal_espana_contabilidad_subnet_az1_id" {
#   value = aws_subnet.sucursal_espana_contabilidad_az1.id
# }
# output "sucursal_espana_contabilidad_subnet_az2_id" {
#   value = aws_subnet.sucursal_espana_contabilidad_az2.id
# }
#
# # Ventas
# output "sucursal_espana_ventas_subnet_az1_id" {
#   value = aws_subnet.sucursal_espana_ventas_az1.id
# }
# output "sucursal_espana_ventas_subnet_az2_id" {
#   value = aws_subnet.sucursal_espana_ventas_az2.id
# }
#
# # Periféricos
# output "sucursal_espana_perifericos_subnet_az1_id" {
#   value = aws_subnet.sucursal_espana_perifericos_az1.id
# }
# output "sucursal_espana_perifericos_subnet_az2_id" {
#   value = aws_subnet.sucursal_espana_perifericos_az2.id
# }
#
# # Ejemplo outputs de instancias EC2 (solo informática, puedes copiar para otros departamentos)
# output "sucursal_espana_informatica_ec2_az1_private_ip" {
#   value = aws_instance.sucursal_espana_informatica_ec2_az1.private_ip
# }
# output "sucursal_espana_informatica_ec2_az2_private_ip" {
#   value = aws_instance.sucursal_espana_informatica_ec2_az2.private_ip
# }

