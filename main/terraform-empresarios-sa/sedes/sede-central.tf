resource "aws_vpc" "sede_central" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = { Name = "VPC-Sede-Central" }
}

resource "aws_internet_gateway" "central_igw" {
  vpc_id = aws_vpc.sede_central.id
  tags   = { Name = "Central-IGW" }
}

# -------- SUBRED PUBLICA ÚNICA --------
resource "aws_subnet" "public_subnet_central" {
  vpc_id                  = aws_vpc.sede_central.id
  cidr_block              = "10.0.200.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = { Name = "Public-Subnet-Central" }
}

# -------- ROUTE TABLE --------
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.sede_central.id
  tags   = { Name = "Central-Public-RT" }
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

# -------- SECURITY GROUP --------
resource "aws_security_group" "public_sg" {
  name        = "public-sg"
  description = "Permite HTTP/HTTPS y SSH desde Internet"
  vpc_id      = aws_vpc.sede_central.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permite SSH desde cualquier lugar"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permite HTTP desde cualquier lugar"
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permite HTTPS desde cualquier lugar"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "Public-Access" }
}

# -------- INSTANCIA PUBLICA --------
resource "aws_instance" "central_ec2" {
  ami                         = "ami-0c94855ba95c71c99"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_central.id
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  key_name                    = "bastion_key"
  associate_public_ip_address = true
  tags = { Name = "Central-EC2" }
}

# --- (Peering y rutas para peering puedes agregarlas abajo si lo necesitas) ---

# --- PEERING (lo puedes declarar aquí o en la sucursal, pero debe ser uno solo en todo el proyecto) ---
resource "aws_vpc_peering_connection" "central_to_sucursal_1" {
  vpc_id        = aws_vpc.sede_central.id
  peer_vpc_id   = aws_vpc.sucursal_1.id
  auto_accept   = true
  tags = {
    Name = "Central-to-Sucursal-1"
  }
}

# --- RUTA en la central para alcanzar la sucursal 1 ---
resource "aws_route" "central_to_sucursal_1" {
  route_table_id            = aws_route_table.public_rt.id
  destination_cidr_block    = aws_vpc.sucursal_1.cidr_block   # "10.10.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.central_to_sucursal_1.id
}

# --- PEERING central <-> sucursal 2 ---
resource "aws_vpc_peering_connection" "central_to_sucursal_2" {
  vpc_id        = aws_vpc.sede_central.id
  peer_vpc_id   = aws_vpc.sucursal_2.id
  auto_accept   = true
  tags = {
    Name = "Central-to-Sucursal-2"
  }
}

# --- RUTA en la central para alcanzar la sucursal 2 ---
resource "aws_route" "central_to_sucursal_2" {
  route_table_id            = aws_route_table.public_rt.id
  destination_cidr_block    = aws_vpc.sucursal_2.cidr_block   # "10.20.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.central_to_sucursal_2.id
}


# Peering entre la sede central y sucursal USA
resource "aws_vpc_peering_connection" "central_to_sucursal_usa" {
  vpc_id        = aws_vpc.sede_central.id
  peer_vpc_id   = aws_vpc.sucursal_usa.id
  auto_accept   = true
  tags = {
    Name = "Central-to-Sucursal-USA"
  }
}

# Ruta en la central para alcanzar Sucursal USA
resource "aws_route" "central_to_sucursal_usa" {
  route_table_id            = aws_route_table.public_rt.id
  destination_cidr_block    = aws_vpc.sucursal_usa.cidr_block   # "10.40.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.central_to_sucursal_usa.id
}

resource "aws_vpc_peering_connection" "central_to_sucursal_espana" {
  vpc_id        = aws_vpc.sede_central.id
  peer_vpc_id   = aws_vpc.sucursal_espana.id
  auto_accept   = true
  tags = {
    Name = "Central-to-Sucursal-España"
  }
}

resource "aws_route" "central_to_sucursal_espana" {
  route_table_id            = aws_route_table.public_rt.id
  destination_cidr_block    = aws_vpc.sucursal_espana.cidr_block   # "10.50.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.central_to_sucursal_espana.id
}

# resource "aws_vpc_peering_connection" "central_to_sucursal_3" {
#   vpc_id        = aws_vpc.sede_central.id
#   peer_vpc_id   = aws_vpc.sucursal_3.id
#   auto_accept   = true
#   tags = {
#     Name = "Central-to-Sucursal-3"
#   }
# }
#
# resource "aws_route" "central_to_sucursal_3" {
#   route_table_id            = aws_route_table.public_rt.id
#   destination_cidr_block    = aws_vpc.sucursal_3.cidr_block   # "10.30.0.0/16"
#   vpc_peering_connection_id = aws_vpc_peering_connection.central_to_sucursal_3.id
# }
