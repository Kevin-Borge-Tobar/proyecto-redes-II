# ---------------------------------
# Outputs Sucursal 1 (Multi-AZ)
# ---------------------------------
output "vpc_id_sucursal_1" {
  value = aws_vpc.sucursal_1.id
}

output "sucursal_1_public_subnet_az1_id" {
  value = aws_subnet.sucursal_1_public_az1.id
}
output "sucursal_1_public_subnet_az2_id" {
  value = aws_subnet.sucursal_1_public_az2.id
}

output "sucursal_1_gerencia_subnet_az1_id" {
  value = aws_subnet.sucursal_1_gerencia_az1.id
}
output "sucursal_1_gerencia_subnet_az2_id" {
  value = aws_subnet.sucursal_1_gerencia_az2.id
}

output "sucursal_1_private_rt_id" {
  value = aws_route_table.sucursal_1_private_rt.id
}

output "sucursal_1_security_group_id" {
  value = aws_security_group.sucursal_1_sg.id
}


output "sucursal_1_gerencia_ec2_az1_private_ip" {
  value = aws_instance.sucursal_1_gerencia_ec2_az1.private_ip
}
output "sucursal_1_gerencia_ec2_az2_private_ip" {
  value = aws_instance.sucursal_1_gerencia_ec2_az2.private_ip
}
