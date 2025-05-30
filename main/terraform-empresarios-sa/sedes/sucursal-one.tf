resource "aws_vpc" "sucursal_1" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true
  tags = { Name = "VPC-Sucursal-1" }
}

resource "aws_internet_gateway" "sucursal_1_igw" {
  vpc_id = aws_vpc.sucursal_1.id
  tags   = { Name = "Sucursal-1-IGW" }
}

# Subredes por departamento y periféricos
resource "aws_subnet" "gerencia_1" {
  vpc_id            = aws_vpc.sucursal_1.id
  cidr_block        = "10.10.10.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Gerencia-Sucursal-1" }
}
resource "aws_subnet" "rrhh_1" {
  vpc_id            = aws_vpc.sucursal_1.id
  cidr_block        = "10.10.20.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "RRHH-Sucursal-1" }
}
resource "aws_subnet" "informatica_1" {
  vpc_id            = aws_vpc.sucursal_1.id
  cidr_block        = "10.10.30.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Informatica-Sucursal-1" }
}
resource "aws_subnet" "contabilidad_1" {
  vpc_id            = aws_vpc.sucursal_1.id
  cidr_block        = "10.10.40.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Contabilidad-Sucursal-1" }
}
resource "aws_subnet" "ventas_1" {
  vpc_id            = aws_vpc.sucursal_1.id
  cidr_block        = "10.10.50.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Ventas-Sucursal-1" }
}
resource "aws_subnet" "perifericos_1" {
  vpc_id            = aws_vpc.sucursal_1.id
  cidr_block        = "10.10.60.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Perifericos-Sucursal-1" }
}

# Route Table y asociaciones para todas las subredes
resource "aws_route_table" "public_rt_sucursal_1" {
  vpc_id = aws_vpc.sucursal_1.id
  tags   = { Name = "Sucursal-1-Public-RT" }
}

resource "aws_route" "public_internet_access_sucursal_1" {
  route_table_id         = aws_route_table.public_rt_sucursal_1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.sucursal_1_igw.id
}

resource "aws_route_table_association" "gerencia_assoc_1" {
  subnet_id      = aws_subnet.gerencia_1.id
  route_table_id = aws_route_table.public_rt_sucursal_1.id
}
resource "aws_route_table_association" "rrhh_assoc_1" {
  subnet_id      = aws_subnet.rrhh_1.id
  route_table_id = aws_route_table.public_rt_sucursal_1.id
}
resource "aws_route_table_association" "informatica_assoc_1" {
  subnet_id      = aws_subnet.informatica_1.id
  route_table_id = aws_route_table.public_rt_sucursal_1.id
}
resource "aws_route_table_association" "contabilidad_assoc_1" {
  subnet_id      = aws_subnet.contabilidad_1.id
  route_table_id = aws_route_table.public_rt_sucursal_1.id
}
resource "aws_route_table_association" "ventas_assoc_1" {
  subnet_id      = aws_subnet.ventas_1.id
  route_table_id = aws_route_table.public_rt_sucursal_1.id
}
resource "aws_route_table_association" "perifericos_assoc_1" {
  subnet_id      = aws_subnet.perifericos_1.id
  route_table_id = aws_route_table.public_rt_sucursal_1.id
}

# Security Group: SSH y ping solo desde la sede central
resource "aws_security_group" "public_sg_sucursal_1" {
  name        = "public-sg-sucursal-1"
  description = "Permite SSH solo desde la sede central"
  vpc_id      = aws_vpc.sucursal_1.id

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
  tags = { Name = "Public-Access-Sucursal-1" }
}

# Instancias por departamento (una por subred)
resource "aws_instance" "gerencia_ec2_1" {
  ami                         = "ami-0c94855ba95c71c99"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.gerencia_1.id
  vpc_security_group_ids      = [aws_security_group.public_sg_sucursal_1.id]
  key_name                    = "bastion_key"
  associate_public_ip_address = false
  tags = { Name = "Gerencia-EC2-Sucursal-1" }
}
resource "aws_instance" "rrhh_ec2_1" {
  ami                         = "ami-0c94855ba95c71c99"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.rrhh_1.id
  vpc_security_group_ids      = [aws_security_group.public_sg_sucursal_1.id]
  key_name                    = "bastion_key"
  associate_public_ip_address = false
  tags = { Name = "RRHH-EC2-Sucursal-1" }
}
resource "aws_instance" "informatica_ec2_1" {
  ami                         = "ami-0c94855ba95c71c99"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.informatica_1.id
  vpc_security_group_ids      = [aws_security_group.public_sg_sucursal_1.id]
  key_name                    = "bastion_key"
  associate_public_ip_address = false
  tags = { Name = "Informatica-EC2-Sucursal-1" }
}
resource "aws_instance" "contabilidad_ec2_1" {
  ami                         = "ami-0c94855ba95c71c99"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.contabilidad_1.id
  vpc_security_group_ids      = [aws_security_group.public_sg_sucursal_1.id]
  key_name                    = "bastion_key"
  associate_public_ip_address = false
  tags = { Name = "Contabilidad-EC2-Sucursal-1" }
}
resource "aws_instance" "ventas_ec2_1" {
  ami                         = "ami-0c94855ba95c71c99"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.ventas_1.id
  vpc_security_group_ids      = [aws_security_group.public_sg_sucursal_1.id]
  key_name                    = "bastion_key"
  associate_public_ip_address = false
  tags = { Name = "Ventas-EC2-Sucursal-1" }
}
resource "aws_instance" "perifericos_ec2_1" {
  ami                         = "ami-0c94855ba95c71c99"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.perifericos_1.id
  vpc_security_group_ids      = [aws_security_group.public_sg_sucursal_1.id]
  key_name                    = "bastion_key"
  associate_public_ip_address = false
  tags = { Name = "Periferico-EC2-Sucursal-1" }
}

# --- Ruta de peering de regreso a la central ---
resource "aws_route" "sucursal_1_to_central" {
  route_table_id            = aws_route_table.public_rt_sucursal_1.id
  destination_cidr_block    = aws_vpc.sede_central.cidr_block   # "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.central_to_sucursal_1.id
}
