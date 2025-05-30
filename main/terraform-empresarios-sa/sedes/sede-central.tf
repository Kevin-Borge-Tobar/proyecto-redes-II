# ==========================
# Sede Central Empresarios S.A.
# ==========================

resource "aws_vpc" "sede_central" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = { Name = "VPC-Sede-Central" }
}

resource "aws_internet_gateway" "central_igw" {
  vpc_id = aws_vpc.sede_central.id
  tags   = { Name = "Central-IGW" }
}

# ---------- SUBREDES PUBLICAS ----------
resource "aws_subnet" "public_subnet_central_az1" {
  vpc_id                  = aws_vpc.sede_central.id
  cidr_block              = "10.0.200.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = { Name = "Public-Subnet-Central-AZ1" }
}
resource "aws_subnet" "public_subnet_central_az2" {
  vpc_id                  = aws_vpc.sede_central.id
  cidr_block              = "10.0.201.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = { Name = "Public-Subnet-Central-AZ2" }
}

# ---------- SUBREDES PRIVADAS ----------
resource "aws_subnet" "gerencia_az1" {
  vpc_id            = aws_vpc.sede_central.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Gerencia-AZ1" }
}
resource "aws_subnet" "gerencia_az2" {
  vpc_id            = aws_vpc.sede_central.id
  cidr_block        = "10.0.11.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "Gerencia-AZ2" }
}

# ---------- ROUTE TABLES Y ASOCIACIONES ----------
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.sede_central.id
  tags   = { Name = "Central-Public-RT" }
}
resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.central_igw.id
}
resource "aws_route_table_association" "public_subnet_assoc_az1" {
  subnet_id      = aws_subnet.public_subnet_central_az1.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "public_subnet_assoc_az2" {
  subnet_id      = aws_subnet.public_subnet_central_az2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "central_private_rt" {
  vpc_id = aws_vpc.sede_central.id
  tags   = { Name = "Central-Private-RT" }
}
resource "aws_route_table_association" "gerencia_az1" {
  subnet_id      = aws_subnet.gerencia_az1.id
  route_table_id = aws_route_table.central_private_rt.id
}
resource "aws_route_table_association" "gerencia_az2" {
  subnet_id      = aws_subnet.gerencia_az2.id
  route_table_id = aws_route_table.central_private_rt.id
}

# ---------- SECURITY GROUPS ----------
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

resource "aws_security_group" "private_sg" {
  name        = "private-sg"
  description = "Permite trafico entre la sede central y sucursal 1"
  vpc_id      = aws_vpc.sede_central.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.10.0.0/16"] # Sucursal 1
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "Private-Access" }
}



resource "aws_route" "central_to_sucursal_1" {
  route_table_id            = aws_route_table.central_private_rt.id
  destination_cidr_block    = "10.10.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.sucursal_1_to_central.id
}

# ---------- INSTANCIAS DEPARTAMENTALES EN SUBREDES PUBLICAS ----------
resource "aws_instance" "gerencia_ec2_az1" {
  ami                         = "ami-0c94855ba95c71c99"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_central_az1.id
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  key_name                    = "bastion_key"
  associate_public_ip_address = true
  tags = { Name = "Gerencia-EC2-AZ1" }
}

resource "aws_instance" "gerencia_ec2_az2" {
  ami                         = "ami-0c94855ba95c71c99"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_central_az2.id
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  key_name                    = "bastion_key"
  associate_public_ip_address = true
  tags = { Name = "Gerencia-EC2-AZ2" }
}


resource "aws_vpc_peering_connection" "sucursal_1_to_central" {
  vpc_id        = aws_vpc.sede_central.id
  peer_vpc_id   = aws_vpc.sucursal_1.id
  auto_accept   = true

  tags = {
    Name = "Sucursal-1-to-Sede-Central"
  }
}

# resource "aws_route" "central_to_sucursal_1" {
#   route_table_id            = aws_route_table.central_private_rt.id
#   destination_cidr_block    = aws_vpc.sucursal_1.cidr_block
#   vpc_peering_connection_id = aws_vpc_peering_connection.sucursal_1_to_central.id
# }

