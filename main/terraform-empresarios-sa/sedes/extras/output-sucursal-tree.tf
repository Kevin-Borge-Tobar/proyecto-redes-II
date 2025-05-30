


# ---------------------------------
# Outputs Sucursal 3 (Multi-AZ)
# ---------------------------------

output "vpc_id_sucursal_3" {
  value = aws_vpc.sucursal_3.id
}

# Gerencia
output "sucursal_3_gerencia_subnet_az1_id" {
  value = aws_subnet.sucursal_3_gerencia_az1.id
}
output "sucursal_3_gerencia_subnet_az2_id" {
  value = aws_subnet.sucursal_3_gerencia_az2.id
}

# RH
output "sucursal_3_rh_subnet_az1_id" {
  value = aws_subnet.sucursal_3_rh_az1.id
}
output "sucursal_3_rh_subnet_az2_id" {
  value = aws_subnet.sucursal_3_rh_az2.id
}

# Informática
output "sucursal_3_informatica_subnet_az1_id" {
  value = aws_subnet.sucursal_3_informatica_az1.id
}
output "sucursal_3_informatica_subnet_az2_id" {
  value = aws_subnet.sucursal_3_informatica_az2.id
}

# Contabilidad
output "sucursal_3_contabilidad_subnet_az1_id" {
  value = aws_subnet.sucursal_3_contabilidad_az1.id
}
output "sucursal_3_contabilidad_subnet_az2_id" {
  value = aws_subnet.sucursal_3_contabilidad_az2.id
}

# Ventas
output "sucursal_3_ventas_subnet_az1_id" {
  value = aws_subnet.sucursal_3_ventas_az1.id
}
output "sucursal_3_ventas_subnet_az2_id" {
  value = aws_subnet.sucursal_3_ventas_az2.id
}

# Periféricos
output "sucursal_3_perifericos_subnet_az1_id" {
  value = aws_subnet.sucursal_3_perifericos_az1.id
}
output "sucursal_3_perifericos_subnet_az2_id" {
  value = aws_subnet.sucursal_3_perifericos_az2.id
}

# Ejemplo: salidas de instancias EC2 privadas (solo informática)
output "sucursal_3_informatica_ec2_az1_private_ip" {
  value = aws_instance.sucursal_3_informatica_ec2_az1.private_ip
}
output "sucursal_3_informatica_ec2_az2_private_ip" {
  value = aws_instance.sucursal_3_informatica_ec2_az2.private_ip
}
