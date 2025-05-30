resource "aws_vpc" "sucursal_1" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true
  tags = { Name = "VPC-Sucursal-1" }
}

resource "aws_internet_gateway" "sucursal_1_igw" {
  vpc_id = aws_vpc.sucursal_1.id
  tags   = { Name = "Sucursal-1-IGW" }
}

# -------- SUBRED PUBLICA ÚNICA --------
resource "aws_subnet" "public_subnet_sucursal_1" {
  vpc_id                  = aws_vpc.sucursal_1.id
  cidr_block              = "10.10.200.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = { Name = "Public-Subnet-Sucursal-1" }
}

# -------- ROUTE TABLE --------
resource "aws_route_table" "public_rt_sucursal_1" {
  vpc_id = aws_vpc.sucursal_1.id
  tags   = { Name = "Sucursal-1-Public-RT" }
}

resource "aws_route" "public_internet_access_sucursal_1" {
  route_table_id         = aws_route_table.public_rt_sucursal_1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.sucursal_1_igw.id
}

resource "aws_route_table_association" "public_subnet_assoc_sucursal_1" {
  subnet_id      = aws_subnet.public_subnet_sucursal_1.id
  route_table_id = aws_route_table.public_rt_sucursal_1.id
}

# -------- SECURITY GROUP --------
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

# -------- INSTANCIA PUBLICA --------
resource "aws_instance" "sucursal_1_ec2" {
  ami                         = "ami-0c94855ba95c71c99"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_sucursal_1.id
  vpc_security_group_ids      = [aws_security_group.public_sg_sucursal_1.id]
  key_name                    = "bastion_key"
  associate_public_ip_address = true
  tags = { Name = "Sucursal-1-EC2" }
}

# ----------- PEERING Y RUTAS PARA PEERING -----------
# --- RUTA en la sucursal para alcanzar la sede central ---
resource "aws_route" "sucursal_1_to_central" {
  route_table_id            = aws_route_table.public_rt_sucursal_1.id
  destination_cidr_block    = aws_vpc.sede_central.cidr_block   # "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.central_to_sucursal_1.id
}
