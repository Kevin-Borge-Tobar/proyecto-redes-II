# ----------------------------------------
# Sucursal Espana - "sucursal-espana.tf"
# ----------------------------------------

resource "aws_vpc" "sucursal_espana" {
  cidr_block           = "10.40.0.0/16"
  enable_dns_hostnames = true
  tags = { Name = "VPC-Sucursal-Espana" }
}

resource "aws_internet_gateway" "sucursal_espana_igw" {
  vpc_id = aws_vpc.sucursal_espana.id
  tags   = { Name = "Sucursal-Espana-IGW" }
}

resource "aws_subnet" "sucursal_espana_gerencia" {
  vpc_id            = aws_vpc.sucursal_espana.id
  cidr_block        = "10.40.10.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-Espana-Gerencia" }
}
resource "aws_subnet" "sucursal_espana_rh" {
  vpc_id            = aws_vpc.sucursal_espana.id
  cidr_block        = "10.40.20.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-Espana-RH" }
}
resource "aws_subnet" "sucursal_espana_informatica" {
  vpc_id            = aws_vpc.sucursal_espana.id
  cidr_block        = "10.40.30.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-Espana-Informatica" }
}
resource "aws_subnet" "sucursal_espana_contabilidad" {
  vpc_id            = aws_vpc.sucursal_espana.id
  cidr_block        = "10.40.40.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-Espana-Contabilidad" }
}
resource "aws_subnet" "sucursal_espana_ventas" {
  vpc_id            = aws_vpc.sucursal_espana.id
  cidr_block        = "10.40.50.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-Espana-Ventas" }
}
resource "aws_subnet" "sucursal_espana_perifericos" {
  vpc_id            = aws_vpc.sucursal_espana.id
  cidr_block        = "10.40.100.0/24"
  availability_zone = "us-east-1c"
  tags = { Name = "Sucursal-Espana-Perifericos" }
}

resource "aws_route_table" "sucursal_espana_rt" {
  vpc_id = aws_vpc.sucursal_espana.id
  tags   = { Name = "Sucursal-Espana-RT" }
}

resource "aws_route" "sucursal_espana_internet" {
  route_table_id         = aws_route_table.sucursal_espana_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.sucursal_espana_igw.id
}

resource "aws_route_table_association" "sucursal_espana_informatica_assoc" {
  subnet_id      = aws_subnet.sucursal_espana_informatica.id
  route_table_id = aws_route_table.sucursal_espana_rt.id
}

resource "aws_security_group" "sucursal_espana_sg" {
  name        = "Sucursal-Espana-SG"
  description = "Permite SSH solo desde la sede central"
  vpc_id      = aws_vpc.sucursal_espana.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # <--- CIDR sede central
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "Sucursal-Espana-SG" }
}

resource "aws_instance" "sucursal_espana_informatica_ec2" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.sucursal_espana_informatica.id
  vpc_security_group_ids = [aws_security_group.sucursal_espana_sg.id]
  tags = { Name = "Sucursal-Espana-Informatica-EC2" }
}
