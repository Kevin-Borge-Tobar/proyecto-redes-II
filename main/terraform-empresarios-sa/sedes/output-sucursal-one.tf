output "sucursal_1_instance_private_ip" {
  description = "IP privada de la instancia en sucursal 1"
  value       = aws_instance.sucursal_1_ec2.private_ip
}

output "sucursal_1_instance_public_ip" {
  description = "IP pública de la instancia en sucursal 1"
  value       = aws_instance.sucursal_1_ec2.public_ip
}

output "sucursal_1_vpc_id" {
  description = "VPC ID de la sucursal 1"
  value       = aws_vpc.sucursal_1.id
}


