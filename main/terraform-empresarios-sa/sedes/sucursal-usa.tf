# ----------------------------------------
# Sucursal USA - "sucursal-usa.tf"
# ----------------------------------------

resource "aws_vpc" "sucursal_usa" {
  cidr_block           = "10.50.0.0/16"
  enable_dns_hostnames = true
  tags = { Name = "VPC-Sucursal-USA" }
}

resource "aws_internet_gateway" "sucursal_usa_igw" {
  vpc_id = aws_vpc.sucursal_usa.id
  tags   = { Name = "Sucursal-USA-IGW" }
}

resource "aws_subnet" "sucursal_usa_gerencia" {
  vpc_id            = aws_vpc.sucursal_usa.id
  cidr_block        = "10.50.10.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-USA-Gerencia" }
}
resource "aws_subnet" "sucursal_usa_rh" {
  vpc_id            = aws_vpc.sucursal_usa.id
  cidr_block        = "10.50.20.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-USA-RH" }
}
resource "aws_subnet" "sucursal_usa_informatica" {
  vpc_id            = aws_vpc.sucursal_usa.id
  cidr_block        = "10.50.30.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-USA-Informatica" }
}
resource "aws_subnet" "sucursal_usa_contabilidad" {
  vpc_id            = aws_vpc.sucursal_usa.id
  cidr_block        = "10.50.40.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-USA-Contabilidad" }
}
resource "aws_subnet" "sucursal_usa_ventas" {
  vpc_id            = aws_vpc.sucursal_usa.id
  cidr_block        = "10.50.50.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-USA-Ventas" }
}
resource "aws_subnet" "sucursal_usa_perifericos" {
  vpc_id            = aws_vpc.sucursal_usa.id
  cidr_block        = "10.50.100.0/24"
  availability_zone = "us-east-1c"
  tags = { Name = "Sucursal-USA-Perifericos" }
}

resource "aws_route_table" "sucursal_usa_rt" {
  vpc_id = aws_vpc.sucursal_usa.id
  tags   = { Name = "Sucursal-USA-RT" }
}

resource "aws_route" "sucursal_usa_internet" {
  route_table_id         = aws_route_table.sucursal_usa_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.sucursal_usa_igw.id
}

resource "aws_route_table_association" "sucursal_usa_informatica_assoc" {
  subnet_id      = aws_subnet.sucursal_usa_informatica.id
  route_table_id = aws_route_table.sucursal_usa_rt.id
}

resource "aws_security_group" "sucursal_usa_sg" {
  name        = "Sucursal-USA-SG"
  description = "Permite SSH solo desde la sede central"
  vpc_id      = aws_vpc.sucursal_usa.id

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
  tags = { Name = "Sucursal-USA-SG" }
}

resource "aws_instance" "sucursal_usa_informatica_ec2" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.sucursal_usa_informatica.id
  vpc_security_group_ids = [aws_security_group.sucursal_usa_sg.id]
  tags = { Name = "Sucursal-USA-Informatica-EC2" }
}
