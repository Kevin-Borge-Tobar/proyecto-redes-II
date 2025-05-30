resource "aws_vpc" "sucursal_2" {
  cidr_block           = "10.20.0.0/16"
  enable_dns_hostnames = true
  tags = { Name = "VPC-Sucursal-2" }
}

resource "aws_internet_gateway" "sucursal_2_igw" {
  vpc_id = aws_vpc.sucursal_2.id
  tags   = { Name = "Sucursal-2-IGW" }
}

# Subredes para departamentos
resource "aws_subnet" "gerencia" {
  vpc_id            = aws_vpc.sucursal_2.id
  cidr_block        = "10.20.10.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Gerencia-Sucursal-2" }
}
resource "aws_subnet" "rrhh" {
  vpc_id            = aws_vpc.sucursal_2.id
  cidr_block        = "10.20.20.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "RRHH-Sucursal-2" }
}
resource "aws_subnet" "informatica" {
  vpc_id            = aws_vpc.sucursal_2.id
  cidr_block        = "10.20.30.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Informatica-Sucursal-2" }
}
resource "aws_subnet" "contabilidad" {
  vpc_id            = aws_vpc.sucursal_2.id
  cidr_block        = "10.20.40.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Contabilidad-Sucursal-2" }
}
resource "aws_subnet" "ventas" {
  vpc_id            = aws_vpc.sucursal_2.id
  cidr_block        = "10.20.50.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Ventas-Sucursal-2" }
}

# Route table común para todas
resource "aws_route_table" "public_rt_sucursal_2" {
  vpc_id = aws_vpc.sucursal_2.id
  tags   = { Name = "Sucursal-2-Public-RT" }
}

# Asociaciones
resource "aws_route_table_association" "gerencia_assoc" {
  subnet_id      = aws_subnet.gerencia.id
  route_table_id = aws_route_table.public_rt_sucursal_2.id
}
resource "aws_route_table_association" "rrhh_assoc" {
  subnet_id      = aws_subnet.rrhh.id
  route_table_id = aws_route_table.public_rt_sucursal_2.id
}
resource "aws_route_table_association" "informatica_assoc" {
  subnet_id      = aws_subnet.informatica.id
  route_table_id = aws_route_table.public_rt_sucursal_2.id
}
resource "aws_route_table_association" "contabilidad_assoc" {
  subnet_id      = aws_subnet.contabilidad.id
  route_table_id = aws_route_table.public_rt_sucursal_2.id
}
resource "aws_route_table_association" "ventas_assoc" {
  subnet_id      = aws_subnet.ventas.id
  route_table_id = aws_route_table.public_rt_sucursal_2.id
}

# Ruta para acceso a Internet (si quieres que tengan acceso)
resource "aws_route" "public_internet_access_sucursal_2" {
  route_table_id         = aws_route_table.public_rt_sucursal_2.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.sucursal_2_igw.id
}

# Security Group para permitir acceso solo desde la central
resource "aws_security_group" "public_sg_sucursal_2" {
  name        = "public-sg-sucursal-2"
  description = "Permite SSH solo desde la sede central"
  vpc_id      = aws_vpc.sucursal_2.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
    description = "Permite SSH desde la sede central"
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/16"]
    description = "Permite ping desde la sede central"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "Public-Access-Sucursal-2" }
}

# Una instancia por subred (por departamento)
resource "aws_instance" "gerencia_ec2" {
  ami                         = "ami-0c94855ba95c71c99"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.gerencia.id
  vpc_security_group_ids      = [aws_security_group.public_sg_sucursal_2.id]
  key_name                    = "bastion_key"
  associate_public_ip_address = false
  tags = { Name = "Gerencia-EC2-Sucursal-2" }
}
resource "aws_instance" "rrhh_ec2" {
  ami                         = "ami-0c94855ba95c71c99"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.rrhh.id
  vpc_security_group_ids      = [aws_security_group.public_sg_sucursal_2.id]
  key_name                    = "bastion_key"
  associate_public_ip_address = false
  tags = { Name = "RRHH-EC2-Sucursal-2" }
}
resource "aws_instance" "informatica_ec2" {
  ami                         = "ami-0c94855ba95c71c99"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.informatica.id
  vpc_security_group_ids      = [aws_security_group.public_sg_sucursal_2.id]
  key_name                    = "bastion_key"
  associate_public_ip_address = false
  tags = { Name = "Informatica-EC2-Sucursal-2" }
}
resource "aws_instance" "contabilidad_ec2" {
  ami                         = "ami-0c94855ba95c71c99"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.contabilidad.id
  vpc_security_group_ids      = [aws_security_group.public_sg_sucursal_2.id]
  key_name                    = "bastion_key"
  associate_public_ip_address = false
  tags = { Name = "Contabilidad-EC2-Sucursal-2" }
}
resource "aws_instance" "ventas_ec2" {
  ami                         = "ami-0c94855ba95c71c99"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.ventas.id
  vpc_security_group_ids      = [aws_security_group.public_sg_sucursal_2.id]
  key_name                    = "bastion_key"
  associate_public_ip_address = false
  tags = { Name = "Ventas-EC2-Sucursal-2" }
}

# --- Ruta de peering para que todas las subredes de Sucursal 2 puedan acceder a la central ---
resource "aws_route" "sucursal_2_to_central" {
  route_table_id            = aws_route_table.public_rt_sucursal_2.id
  destination_cidr_block    = aws_vpc.sede_central.cidr_block   # "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.central_to_sucursal_2.id
}
