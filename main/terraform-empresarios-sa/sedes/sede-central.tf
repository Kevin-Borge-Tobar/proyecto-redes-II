#VPC de la Sede Central de la institucion Empresarios S.A.
# el cual será la red principal de interconexión para las redes a crear
# Esta VPC será la que controlara los departamentos y servicios principales
# Equivalente a la red LAN de una red física.
#IPS posibles 65,536
resource "aws_vpc" "sede_central" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = { Name = "VPC-Sede-Central" }
}

# Internet Gateway (IGW)
# Permite que recursos dentro de la VPC puedan acceder y ser accedidos desde internet
# Representa a un router en una red física
resource "aws_internet_gateway" "central_igw" {
  vpc_id = aws_vpc.sede_central.id
  tags = { Name = "Central-IGW" }
}

#Subred publica de la sede Central para los visitantes/publico general
resource "aws_subnet" "public_subnet_central" {
  vpc_id                  = aws_vpc.sede_central.id
  cidr_block              = "10.0.200.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = { Name = "Public-Subnet-Central" }
}

#Subredes privadas para los departamentos
# Departamento de Gerencia
resource "aws_subnet" "gerencia" {
  vpc_id            = aws_vpc.sede_central.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Gerencia" }
}
# Departamento de Recursos Humanos
resource "aws_subnet" "rh" {
  vpc_id            = aws_vpc.sede_central.id
  cidr_block        = "10.0.20.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "RH" }
}
# Departamento de Informatica
resource "aws_subnet" "informatica" {
  vpc_id            = aws_vpc.sede_central.id
  cidr_block        = "10.0.30.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Informatica" }
}

# Departamento de Contabilidad
resource "aws_subnet" "contabilidad" {
  vpc_id            = aws_vpc.sede_central.id
  cidr_block        = "10.0.40.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Contabilidad" }
}

# Departamento de Ventas
resource "aws_subnet" "ventas" {
  vpc_id            = aws_vpc.sede_central.id
  cidr_block        = "10.0.50.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Ventas" }
}

# Periféricos (impresoras, cámaras, telefonía, etc)
resource "aws_subnet" "perifericos" {
  vpc_id            = aws_vpc.sede_central.id
  cidr_block        = "10.0.100.0/24"
  availability_zone = "us-east-1c"
  tags = { Name = "Perifericos" }
}

#Tabla de rutas publicas y su respectiva asociación
#Define como debe de salir el trafico hacia la red publica
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.sede_central.id
  tags = { Name = "Central-Public-RT" }
}
resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.central_igw.id
}
resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id      = aws_subnet.public_subnet_central.id
  route_table_id = aws_route_table.public_rt.id
}

# Security group para servidor público (HTTP y SSH desde internet)
#Es como el firewall que decide que trafico puede entrar o salir de los servidores públicos
resource "aws_security_group" "public_sg" {
  name        = "public-sg"
  description = "Permite HTTP/HTTPS y SSH desde Internet"
  vpc_id      = aws_vpc.sede_central.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "Public-Access" }
}

# Security group privado para los departamentos internos
resource "aws_security_group" "private_sg" {
  name        = "private-sg"
  description = "Acceso solo interno"
  vpc_id      = aws_vpc.sede_central.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # cidr_blocks = var.ssh_admin_ips
    cidr_blocks = ["10.0.0.0/16"] #deja solo las IPS de la vpc central

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "Private-Access" }
}

# Instancia EC2 pública (para acceso de clientes/visitantes)
resource "aws_instance" "public_server" {
  ami                         = "ami-0c94855ba95c71c99" # Actualiza AMI si es necesario para tu región
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_subnet_central.id
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  associate_public_ip_address = true
  tags = { Name = "Public-EC2" }
}

# Instancias EC2 privadas por departamento
resource "aws_instance" "gerencia_ec2" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.gerencia.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  tags = { Name = "Gerencia-EC2" }
}
resource "aws_instance" "rh_ec2" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.rh.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  tags = { Name = "RH-EC2" }
}
resource "aws_instance" "informatica_ec2" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.informatica.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  tags = { Name = "Informatica-EC2" }
}
resource "aws_instance" "contabilidad_ec2" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.contabilidad.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  tags = { Name = "Contabilidad-EC2" }
}
resource "aws_instance" "ventas_ec2" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.ventas.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  tags = { Name = "Ventas-EC2" }
}
resource "aws_instance" "perifericos_ec2" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.perifericos.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  tags = { Name = "Perifericos-EC2" }
}