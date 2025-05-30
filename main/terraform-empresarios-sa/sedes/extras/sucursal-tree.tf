# ----------------------------------------
# Sucursal Nacional 3 - "sucursal-three.tf"
# ----------------------------------------

resource "aws_vpc" "sucursal_3" {
  cidr_block           = "10.30.0.0/16"
  enable_dns_hostnames = true
  tags = { Name = "VPC-Sucursal-3" }
}

resource "aws_internet_gateway" "sucursal_3_igw" {
  vpc_id = aws_vpc.sucursal_3.id
  tags   = { Name = "Sucursal-3-IGW" }
}

# Subredes privadas por departamento (alta disponibilidad, una por AZ)
resource "aws_subnet" "sucursal_3_gerencia_az1" {
  vpc_id            = aws_vpc.sucursal_3.id
  cidr_block        = "10.30.10.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-3-Gerencia-AZ1" }
}
resource "aws_subnet" "sucursal_3_gerencia_az2" {
  vpc_id            = aws_vpc.sucursal_3.id
  cidr_block        = "10.30.11.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "Sucursal-3-Gerencia-AZ2" }
}

resource "aws_subnet" "sucursal_3_rh_az1" {
  vpc_id            = aws_vpc.sucursal_3.id
  cidr_block        = "10.30.20.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-3-RH-AZ1" }
}
resource "aws_subnet" "sucursal_3_rh_az2" {
  vpc_id            = aws_vpc.sucursal_3.id
  cidr_block        = "10.30.21.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "Sucursal-3-RH-AZ2" }
}

resource "aws_subnet" "sucursal_3_informatica_az1" {
  vpc_id            = aws_vpc.sucursal_3.id
  cidr_block        = "10.30.30.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-3-Informatica-AZ1" }
}
resource "aws_subnet" "sucursal_3_informatica_az2" {
  vpc_id            = aws_vpc.sucursal_3.id
  cidr_block        = "10.30.31.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "Sucursal-3-Informatica-AZ2" }
}

resource "aws_subnet" "sucursal_3_contabilidad_az1" {
  vpc_id            = aws_vpc.sucursal_3.id
  cidr_block        = "10.30.40.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-3-Contabilidad-AZ1" }
}
resource "aws_subnet" "sucursal_3_contabilidad_az2" {
  vpc_id            = aws_vpc.sucursal_3.id
  cidr_block        = "10.30.41.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "Sucursal-3-Contabilidad-AZ2" }
}

resource "aws_subnet" "sucursal_3_ventas_az1" {
  vpc_id            = aws_vpc.sucursal_3.id
  cidr_block        = "10.30.50.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-3-Ventas-AZ1" }
}
resource "aws_subnet" "sucursal_3_ventas_az2" {
  vpc_id            = aws_vpc.sucursal_3.id
  cidr_block        = "10.30.51.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "Sucursal-3-Ventas-AZ2" }
}

resource "aws_subnet" "sucursal_3_perifericos_az1" {
  vpc_id            = aws_vpc.sucursal_3.id
  cidr_block        = "10.30.100.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-3-Perifericos-AZ1" }
}
resource "aws_subnet" "sucursal_3_perifericos_az2" {
  vpc_id            = aws_vpc.sucursal_3.id
  cidr_block        = "10.30.101.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "Sucursal-3-Perifericos-AZ2" }
}

resource "aws_route_table" "sucursal_3_rt" {
  vpc_id = aws_vpc.sucursal_3.id
  tags   = { Name = "Sucursal-3-RT" }
}

resource "aws_route" "sucursal_3_internet" {
  route_table_id         = aws_route_table.sucursal_3_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.sucursal_3_igw.id
}

resource "aws_route_table_association" "informatica_assoc_az1" {
  subnet_id      = aws_subnet.sucursal_3_informatica_az1.id
  route_table_id = aws_route_table.sucursal_3_rt.id
}
resource "aws_route_table_association" "informatica_assoc_az2" {
  subnet_id      = aws_subnet.sucursal_3_informatica_az2.id
  route_table_id = aws_route_table.sucursal_3_rt.id
}
# Puedes asociar más privadas según necesites

resource "aws_security_group" "sucursal_3_sg" {
  name        = "Sucursal-3-SG"
  description = "Permite SSH solo desde la sede central"
  vpc_id      = aws_vpc.sucursal_3.id

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
  tags = { Name = "Sucursal-3-SG" }
}

# ---------- INSTANCIAS PRIVADAS POR DEPARTAMENTO (Multi-AZ) ----------

resource "aws_instance" "sucursal_3_gerencia_ec2_az1" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.sucursal_3_gerencia_az1.id
  vpc_security_group_ids = [aws_security_group.sucursal_3_sg.id]
  tags = { Name = "Sucursal-3-Gerencia-EC2-AZ1" }
}
resource "aws_instance" "sucursal_3_gerencia_ec2_az2" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.sucursal_3_gerencia_az2.id
  vpc_security_group_ids = [aws_security_group.sucursal_3_sg.id]
  tags = { Name = "Sucursal-3-Gerencia-EC2-AZ2" }
}

resource "aws_instance" "sucursal_3_rh_ec2_az1" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.sucursal_3_rh_az1.id
  vpc_security_group_ids = [aws_security_group.sucursal_3_sg.id]
  tags = { Name = "Sucursal-3-RH-EC2-AZ1" }
}
resource "aws_instance" "sucursal_3_rh_ec2_az2" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.sucursal_3_rh_az2.id
  vpc_security_group_ids = [aws_security_group.sucursal_3_sg.id]
  tags = { Name = "Sucursal-3-RH-EC2-AZ2" }
}

resource "aws_instance" "sucursal_3_informatica_ec2_az1" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.sucursal_3_informatica_az1.id
  vpc_security_group_ids = [aws_security_group.sucursal_3_sg.id]
  tags = { Name = "Sucursal-3-Informatica-EC2-AZ1" }
}
resource "aws_instance" "sucursal_3_informatica_ec2_az2" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.sucursal_3_informatica_az2.id
  vpc_security_group_ids = [aws_security_group.sucursal_3_sg.id]
  tags = { Name = "Sucursal-3-Informatica-EC2-AZ2" }
}

resource "aws_instance" "sucursal_3_contabilidad_ec2_az1" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.sucursal_3_contabilidad_az1.id
  vpc_security_group_ids = [aws_security_group.sucursal_3_sg.id]
  tags = { Name = "Sucursal-3-Contabilidad-EC2-AZ1" }
}
resource "aws_instance" "sucursal_3_contabilidad_ec2_az2" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.sucursal_3_contabilidad_az2.id
  vpc_security_group_ids = [aws_security_group.sucursal_3_sg.id]
  tags = { Name = "Sucursal-3-Contabilidad-EC2-AZ2" }
}

resource "aws_instance" "sucursal_3_ventas_ec2_az1" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.sucursal_3_ventas_az1.id
  vpc_security_group_ids = [aws_security_group.sucursal_3_sg.id]
  tags = { Name = "Sucursal-3-Ventas-EC2-AZ1" }
}
resource "aws_instance" "sucursal_3_ventas_ec2_az2" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.sucursal_3_ventas_az2.id
  vpc_security_group_ids = [aws_security_group.sucursal_3_sg.id]
  tags = { Name = "Sucursal-3-Ventas-EC2-AZ2" }
}

resource "aws_instance" "sucursal_3_perifericos_ec2_az1" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.sucursal_3_perifericos_az1.id
  vpc_security_group_ids = [aws_security_group.sucursal_3_sg.id]
  tags = { Name = "Sucursal-3-Perifericos-EC2-AZ1" }
}
resource "aws_instance" "sucursal_3_perifericos_ec2_az2" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.sucursal_3_perifericos_az2.id
  vpc_security_group_ids = [aws_security_group.sucursal_3_sg.id]
  tags = { Name = "Sucursal-3-Perifericos-EC2-AZ2" }
}

