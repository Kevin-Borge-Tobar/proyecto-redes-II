# # ----------------------------------------
# # Sucursal Nacional 3 - "sucursal-tree.tf"
# # ----------------------------------------
#
# # VPC de la Sucursal 3
# resource "aws_vpc" "sucursal_3" {
#   cidr_block           = "10.30.0.0/16"
#   enable_dns_hostnames = true
#   tags = { Name = "VPC-Sucursal-3" }
# }
#
# # Internet Gateway para la Sucursal 3
# resource "aws_internet_gateway" "sucursal_3_igw" {
#   vpc_id = aws_vpc.sucursal_3.id
#   tags   = { Name = "Sucursal-3-IGW" }
# }
#
# # Subredes privadas por departamento en la Sucursal 3
# resource "aws_subnet" "sucursal_3_gerencia" {
#   vpc_id            = aws_vpc.sucursal_3.id
#   cidr_block        = "10.30.10.0/24"
#   availability_zone = "us-east-1a"
#   tags = { Name = "Sucursal-3-Gerencia" }
# }
# resource "aws_subnet" "sucursal_3_rh" {
#   vpc_id            = aws_vpc.sucursal_3.id
#   cidr_block        = "10.30.20.0/24"
#   availability_zone = "us-east-1a"
#   tags = { Name = "Sucursal-3-RH" }
# }
# resource "aws_subnet" "sucursal_3_informatica" {
#   vpc_id            = aws_vpc.sucursal_3.id
#   cidr_block        = "10.30.30.0/24"
#   availability_zone = "us-east-1a"
#   tags = { Name = "Sucursal-3-Informatica" }
# }
# resource "aws_subnet" "sucursal_3_contabilidad" {
#   vpc_id            = aws_vpc.sucursal_3.id
#   cidr_block        = "10.30.40.0/24"
#   availability_zone = "us-east-1a"
#   tags = { Name = "Sucursal-3-Contabilidad" }
# }
# resource "aws_subnet" "sucursal_3_ventas" {
#   vpc_id            = aws_vpc.sucursal_3.id
#   cidr_block        = "10.30.50.0/24"
#   availability_zone = "us-east-1a"
#   tags = { Name = "Sucursal-3-Ventas" }
# }
#
# # (Opcional: Subred para periféricos de la sucursal)
# resource "aws_subnet" "sucursal_3_perifericos" {
#   vpc_id            = aws_vpc.sucursal_3.id
#   cidr_block        = "10.30.100.0/24"
#   availability_zone = "us-east-1c"
#   tags = { Name = "Sucursal-3-Perifericos" }
# }
#
# # Tabla de rutas de la Sucursal 3
# resource "aws_route_table" "sucursal_3_rt" {
#   vpc_id = aws_vpc.sucursal_3.id
#   tags   = { Name = "Sucursal-3-RT" }
# }
#
# resource "aws_route" "sucursal_3_internet" {
#   route_table_id         = aws_route_table.sucursal_3_rt.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.sucursal_3_igw.id
# }
#
# # Asocia la tabla de rutas a la subred de informática (puedes asociar a otras si necesitas)
# resource "aws_route_table_association" "sucursal_3_informatica_assoc" {
#   subnet_id      = aws_subnet.sucursal_3_informatica.id
#   route_table_id = aws_route_table.sucursal_3_rt.id
# }
#
# # Security Group: solo permite SSH desde la sede central (ajusta el CIDR si lo parametrizas)
# resource "aws_security_group" "sucursal_3_sg" {
#   name        = "Sucursal-3-SG"
#   description = "Permite SSH solo desde la sede central"
#   vpc_id      = aws_vpc.sucursal_3.id
#
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["10.0.0.0/16"] # <--- CIDR de la sede central
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   tags = { Name = "Sucursal-3-SG" }
# }
#
# # Instancia EC2 en Informática (puedes agregar más por cada subred/departamento)
# resource "aws_instance" "sucursal_3_informatica_ec2" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t3.micro"
#   subnet_id              = aws_subnet.sucursal_3_informatica.id
#   vpc_security_group_ids = [aws_security_group.sucursal_3_sg.id]
#   tags = { Name = "Sucursal-3-Informatica-EC2" }
# }
