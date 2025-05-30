resource "aws_vpc" "sucursal_usa" {
  cidr_block           = "10.40.0.0/16"
  enable_dns_hostnames = true
  tags = { Name = "VPC-Sucursal-USA" }
}

resource "aws_internet_gateway" "sucursal_usa_igw" {
  vpc_id = aws_vpc.sucursal_usa.id
  tags   = { Name = "Sucursal-USA-IGW" }
}

# Subredes por departamento y periféricos
resource "aws_subnet" "gerencia_usa" {
  vpc_id            = aws_vpc.sucursal_usa.id
  cidr_block        = "10.40.10.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Gerencia-Sucursal-USA" }
}
resource "aws_subnet" "rrhh_usa" {
  vpc_id            = aws_vpc.sucursal_usa.id
  cidr_block        = "10.40.20.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "RRHH-Sucursal-USA" }
}
resource "aws_subnet" "informatica_usa" {
  vpc_id            = aws_vpc.sucursal_usa.id
  cidr_block        = "10.40.30.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Informatica-Sucursal-USA" }
}
resource "aws_subnet" "contabilidad_usa" {
  vpc_id            = aws_vpc.sucursal_usa.id
  cidr_block        = "10.40.40.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Contabilidad-Sucursal-USA" }
}
resource "aws_subnet" "ventas_usa" {
  vpc_id            = aws_vpc.sucursal_usa.id
  cidr_block        = "10.40.50.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Ventas-Sucursal-USA" }
}
resource "aws_subnet" "perifericos_usa" {
  vpc_id            = aws_vpc.sucursal_usa.id
  cidr_block        = "10.40.60.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Perifericos-Sucursal-USA" }
}

# Route Table y asociaciones para todas las subredes
resource "aws_route_table" "public_rt_sucursal_usa" {
  vpc_id = aws_vpc.sucursal_usa.id
  tags   = { Name = "Sucursal-USA-Public-RT" }
}

resource "aws_route" "public_internet_access_sucursal_usa" {
  route_table_id         = aws_route_table.public_rt_sucursal_usa.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.sucursal_usa_igw.id
}

resource "aws_route_table_association" "gerencia_assoc_usa" {
  subnet_id      = aws_subnet.gerencia_usa.id
  route_table_id = aws_route_table.public_rt_sucursal_usa.id
}
resource "aws_route_table_association" "rrhh_assoc_usa" {
  subnet_id      = aws_subnet.rrhh_usa.id
  route_table_id = aws_route_table.public_rt_sucursal_usa.id
}
resource "aws_route_table_association" "informatica_assoc_usa" {
  subnet_id      = aws_subnet.informatica_usa.id
  route_table_id = aws_route_table.public_rt_sucursal_usa.id
}
resource "aws_route_table_association" "contabilidad_assoc_usa" {
  subnet_id      = aws_subnet.contabilidad_usa.id
  route_table_id = aws_route_table.public_rt_sucursal_usa.id
}
resource "aws_route_table_association" "ventas_assoc_usa" {
  subnet_id      = aws_subnet.ventas_usa.id
  route_table_id = aws_route_table.public_rt_sucursal_usa.id
}
resource "aws_route_table_association" "perifericos_assoc_usa" {
  subnet_id      = aws_subnet.perifericos_usa.id
  route_table_id = aws_route_table.public_rt_sucursal_usa.id
}

# Security Group: SSH y ping solo desde la sede central
resource "aws_security_group" "public_sg_sucursal_usa" {
  name        = "public-sg-sucursal-usa"
  description = "Permite SSH solo desde la sede central"
  vpc_id      = aws_vpc.sucursal_usa.id

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
  tags = { Name = "Public-Access-Sucursal-USA" }
}

# Instancias por departamento (una por subred)
resource "aws_instance" "gerencia_ec2_usa" {
  ami                         = "ami-0c94855ba95c71c99"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.gerencia_usa.id
  vpc_security_group_ids      = [aws_security_group.public_sg_sucursal_usa.id]
  key_name                    = "bastion_key"
  associate_public_ip_address = false
  tags = { Name = "Gerencia-EC2-Sucursal-USA" }
}
resource "aws_instance" "rrhh_ec2_usa" {
  ami                         = "ami-0c94855ba95c71c99"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.rrhh_usa.id
  vpc_security_group_ids      = [aws_security_group.public_sg_sucursal_usa.id]
  key_name                    = "bastion_key"
  associate_public_ip_address = false
  tags = { Name = "RRHH-EC2-Sucursal-USA" }
}
resource "aws_instance" "informatica_ec2_usa" {
  ami                         = "ami-0c94855ba95c71c99"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.informatica_usa.id
  vpc_security_group_ids      = [aws_security_group.public_sg_sucursal_usa.id]
  key_name                    = "bastion_key"
  associate_public_ip_address = false
  tags = { Name = "Informatica-EC2-Sucursal-USA" }
}
resource "aws_instance" "contabilidad_ec2_usa" {
  ami                         = "ami-0c94855ba95c71c99"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.contabilidad_usa.id
  vpc_security_group_ids      = [aws_security_group.public_sg_sucursal_usa.id]
  key_name                    = "bastion_key"
  associate_public_ip_address = false
  tags = { Name = "Contabilidad-EC2-Sucursal-USA" }
}
resource "aws_instance" "ventas_ec2_usa" {
  ami                         = "ami-0c94855ba95c71c99"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.ventas_usa.id
  vpc_security_group_ids      = [aws_security_group.public_sg_sucursal_usa.id]
  key_name                    = "bastion_key"
  associate_public_ip_address = false
  tags = { Name = "Ventas-EC2-Sucursal-USA" }
}
resource "aws_instance" "perifericos_ec2_usa" {
  ami                         = "ami-0c94855ba95c71c99"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.perifericos_usa.id
  vpc_security_group_ids      = [aws_security_group.public_sg_sucursal_usa.id]
  key_name                    = "bastion_key"
  associate_public_ip_address = false
  tags = { Name = "Periferico-EC2-Sucursal-USA" }
}

# --- Ruta de peering de regreso a la central ---
resource "aws_route" "sucursal_usa_to_central" {
  route_table_id            = aws_route_table.public_rt_sucursal_usa.id
  destination_cidr_block    = aws_vpc.sede_central.cidr_block   # "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.central_to_sucursal_usa.id
}
