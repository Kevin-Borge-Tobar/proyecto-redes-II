# ----------------------------------------
# Sucursal Nacional 1
# ----------------------------------------

resource "aws_vpc" "sucursal_1" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true
  tags = { Name = "VPC-Sucursal-1" }
}

resource "aws_internet_gateway" "sucursal_1_igw" {
  vpc_id = aws_vpc.sucursal_1.id
  tags   = { Name = "Sucursal-1-IGW" }
}

# ---------- SUBREDES PUBLICAS ----------
resource "aws_subnet" "sucursal_1_public_az1" {
  vpc_id                  = aws_vpc.sucursal_1.id
  cidr_block              = "10.10.200.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = { Name = "Sucursal-1-Public-AZ1" }
}
resource "aws_subnet" "sucursal_1_public_az2" {
  vpc_id                  = aws_vpc.sucursal_1.id
  cidr_block              = "10.10.201.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = { Name = "Sucursal-1-Public-AZ2" }
}

# ---------- SUBREDES PRIVADAS ----------
resource "aws_subnet" "sucursal_1_gerencia_az1" {
  vpc_id            = aws_vpc.sucursal_1.id
  cidr_block        = "10.10.10.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-1-Gerencia-AZ1" }
}
resource "aws_subnet" "sucursal_1_gerencia_az2" {
  vpc_id            = aws_vpc.sucursal_1.id
  cidr_block        = "10.10.11.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "Sucursal-1-Gerencia-AZ2" }
}

# ---------- ROUTE TABLES ----------
resource "aws_route_table" "sucursal_1_private_rt" {
  vpc_id = aws_vpc.sucursal_1.id
  tags   = { Name = "Sucursal-1-Private-RT" }
}

resource "aws_route_table_association" "s1_gerencia_az1_assoc" {
  subnet_id      = aws_subnet.sucursal_1_gerencia_az1.id
  route_table_id = aws_route_table.sucursal_1_private_rt.id
}
resource "aws_route_table_association" "s1_gerencia_az2_assoc" {
  subnet_id      = aws_subnet.sucursal_1_gerencia_az2.id
  route_table_id = aws_route_table.sucursal_1_private_rt.id
}

# ---------- SECURITY GROUPS ----------
resource "aws_security_group" "sucursal_1_sg" {
  name        = "Sucursal-1-SG"
  description = "Permite SSH solo desde la sede central"
  vpc_id      = aws_vpc.sucursal_1.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "Sucursal-1-SG" }
}

# ---------- INSTANCIAS PRIVADAS ----------
resource "aws_instance" "sucursal_1_gerencia_ec2_az1" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.sucursal_1_gerencia_az1.id
  vpc_security_group_ids = [aws_security_group.sucursal_1_sg.id]
  key_name               = "bastion_key"
  tags = { Name = "Sucursal-1-Gerencia-EC2-AZ1" }
}

resource "aws_instance" "sucursal_1_gerencia_ec2_az2" {
  ami                         = "ami-0c94855ba95c71c99"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.sucursal_1_gerencia_az2.id
  vpc_security_group_ids      = [aws_security_group.sucursal_1_sg.id]
  key_name                    = "bastion_key"
  associate_public_ip_address = true
  tags = { Name = "Sucursal-1-Gerencia-EC2-AZ2" }
}