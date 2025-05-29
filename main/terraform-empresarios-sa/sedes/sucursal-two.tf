# ----------------------------------------
# Sucursal Nacional 2 - "sucursal-two.tf"
# ----------------------------------------

# VPC de la Sucursal 2
resource "aws_vpc" "sucursal_2" {
  cidr_block           = "10.20.0.0/16"
  enable_dns_hostnames = true
  tags = { Name = "VPC-Sucursal-2" }
}

# Internet Gateway para la Sucursal 2
resource "aws_internet_gateway" "sucursal_2_igw" {
  vpc_id = aws_vpc.sucursal_2.id
  tags   = { Name = "Sucursal-2-IGW" }
}

# Subredes privadas por departamento en la Sucursal 2
resource "aws_subnet" "sucursal_2_gerencia" {
  vpc_id            = aws_vpc.sucursal_2.id
  cidr_block        = "10.20.10.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-2-Gerencia" }
}
resource "aws_subnet" "sucursal_2_rh" {
  vpc_id            = aws_vpc.sucursal_2.id
  cidr_block        = "10.20.20.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-2-RH" }
}
resource "aws_subnet" "sucursal_2_informatica" {
  vpc_id            = aws_vpc.sucursal_2.id
  cidr_block        = "10.20.30.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-2-Informatica" }
}
resource "aws_subnet" "sucursal_2_contabilidad" {
  vpc_id            = aws_vpc.sucursal_2.id
  cidr_block        = "10.20.40.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-2-Contabilidad" }
}
resource "aws_subnet" "sucursal_2_ventas" {
  vpc_id            = aws_vpc.sucursal_2.id
  cidr_block        = "10.20.50.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-2-Ventas" }
}

# (Opcional: Subred para periféricos de la sucursal)
resource "aws_subnet" "sucursal_2_perifericos" {
  vpc_id            = aws_vpc.sucursal_2.id
  cidr_block        = "10.20.100.0/24"
  availability_zone = "us-east-1c"
  tags = { Name = "Sucursal-2-Perifericos" }
}

# Tabla de rutas de la Sucursal 2
resource "aws_route_table" "sucursal_2_rt" {
  vpc_id = aws_vpc.sucursal_2.id
  tags   = { Name = "Sucursal-2-RT" }
}

resource "aws_route" "sucursal_2_internet" {
  route_table_id         = aws_route_table.sucursal_2_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.sucursal_2_igw.id
}

# Asocia la tabla de rutas a la subred de informática (puedes asociar a otras si necesitas)
resource "aws_route_table_association" "sucursal_2_informatica_assoc" {
  subnet_id      = aws_subnet.sucursal_2_informatica.id
  route_table_id = aws_route_table.sucursal_2_rt.id
}

# Security Group: solo permite SSH desde la sede central (ajusta el CIDR si lo parametrizas)
resource "aws_security_group" "sucursal_2_sg" {
  name        = "Sucursal-2-SG"
  description = "Permite SSH solo desde la sede central"
  vpc_id      = aws_vpc.sucursal_2.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # <--- CIDR de la sede central
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "Sucursal-2-SG" }
}

# Instancia EC2 en Informática (puedes agregar más por cada subred/departamento)
resource "aws_instance" "sucursal_2_informatica_ec2" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.sucursal_2_informatica.id
  vpc_security_group_ids = [aws_security_group.sucursal_2_sg.id]
  tags = { Name = "Sucursal-2-Informatica-EC2" }
}
