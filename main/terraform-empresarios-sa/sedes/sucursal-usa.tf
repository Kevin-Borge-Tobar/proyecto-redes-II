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

# Subredes públicas para HA (puedes usarlas para ALB/ASG si lo necesitas)
resource "aws_subnet" "sucursal_usa_public_az1" {
  vpc_id                  = aws_vpc.sucursal_usa.id
  cidr_block              = "10.50.200.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = { Name = "Sucursal-USA-Public-AZ1" }
}
resource "aws_subnet" "sucursal_usa_public_az2" {
  vpc_id                  = aws_vpc.sucursal_usa.id
  cidr_block              = "10.50.201.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = { Name = "Sucursal-USA-Public-AZ2" }
}

# Subredes privadas por departamento (alta disponibilidad, una por AZ)
resource "aws_subnet" "sucursal_usa_gerencia_az1" {
  vpc_id            = aws_vpc.sucursal_usa.id
  cidr_block        = "10.50.10.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-USA-Gerencia-AZ1" }
}
resource "aws_subnet" "sucursal_usa_gerencia_az2" {
  vpc_id            = aws_vpc.sucursal_usa.id
  cidr_block        = "10.50.11.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "Sucursal-USA-Gerencia-AZ2" }
}

resource "aws_subnet" "sucursal_usa_rh_az1" {
  vpc_id            = aws_vpc.sucursal_usa.id
  cidr_block        = "10.50.20.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-USA-RH-AZ1" }
}
resource "aws_subnet" "sucursal_usa_rh_az2" {
  vpc_id            = aws_vpc.sucursal_usa.id
  cidr_block        = "10.50.21.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "Sucursal-USA-RH-AZ2" }
}

resource "aws_subnet" "sucursal_usa_informatica_az1" {
  vpc_id            = aws_vpc.sucursal_usa.id
  cidr_block        = "10.50.30.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-USA-Informatica-AZ1" }
}
resource "aws_subnet" "sucursal_usa_informatica_az2" {
  vpc_id            = aws_vpc.sucursal_usa.id
  cidr_block        = "10.50.31.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "Sucursal-USA-Informatica-AZ2" }
}

resource "aws_subnet" "sucursal_usa_contabilidad_az1" {
  vpc_id            = aws_vpc.sucursal_usa.id
  cidr_block        = "10.50.40.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-USA-Contabilidad-AZ1" }
}
resource "aws_subnet" "sucursal_usa_contabilidad_az2" {
  vpc_id            = aws_vpc.sucursal_usa.id
  cidr_block        = "10.50.41.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "Sucursal-USA-Contabilidad-AZ2" }
}

resource "aws_subnet" "sucursal_usa_ventas_az1" {
  vpc_id            = aws_vpc.sucursal_usa.id
  cidr_block        = "10.50.50.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-USA-Ventas-AZ1" }
}
resource "aws_subnet" "sucursal_usa_ventas_az2" {
  vpc_id            = aws_vpc.sucursal_usa.id
  cidr_block        = "10.50.51.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "Sucursal-USA-Ventas-AZ2" }
}

resource "aws_subnet" "sucursal_usa_perifericos_az1" {
  vpc_id            = aws_vpc.sucursal_usa.id
  cidr_block        = "10.50.100.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-USA-Perifericos-AZ1" }
}
resource "aws_subnet" "sucursal_usa_perifericos_az2" {
  vpc_id            = aws_vpc.sucursal_usa.id
  cidr_block        = "10.50.101.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "Sucursal-USA-Perifericos-AZ2" }
}

# Tabla de rutas pública
resource "aws_route_table" "sucursal_usa_public_rt" {
  vpc_id = aws_vpc.sucursal_usa.id
  tags   = { Name = "Sucursal-USA-Public-RT" }
}
resource "aws_route" "sucursal_usa_public_internet" {
  route_table_id         = aws_route_table.sucursal_usa_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.sucursal_usa_igw.id
}
resource "aws_route_table_association" "sucursal_usa_public_subnet_assoc_az1" {
  subnet_id      = aws_subnet.sucursal_usa_public_az1.id
  route_table_id = aws_route_table.sucursal_usa_public_rt.id
}
resource "aws_route_table_association" "sucursal_usa_public_subnet_assoc_az2" {
  subnet_id      = aws_subnet.sucursal_usa_public_az2.id
  route_table_id = aws_route_table.sucursal_usa_public_rt.id
}

# Tabla de rutas privadas (puedes asociar a todas las privadas)
resource "aws_route_table" "sucursal_usa_private_rt" {
  vpc_id = aws_vpc.sucursal_usa.id
  tags   = { Name = "Sucursal-USA-Private-RT" }
}
resource "aws_route_table_association" "sucursal_usa_informatica_private_assoc_az1" {
  subnet_id      = aws_subnet.sucursal_usa_informatica_az1.id
  route_table_id = aws_route_table.sucursal_usa_private_rt.id
}
resource "aws_route_table_association" "sucursal_usa_informatica_private_assoc_az2" {
  subnet_id      = aws_subnet.sucursal_usa_informatica_az2.id
  route_table_id = aws_route_table.sucursal_usa_private_rt.id
}
# Puedes repetir para otras privadas con nombres únicos.

# Security Group privado (solo SSH desde Sede Central)
resource "aws_security_group" "sucursal_usa_sg" {
  name        = "Sucursal-USA-SG"
  description = "Permite SSH solo desde la sede central"
  vpc_id      = aws_vpc.sucursal_usa.id

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
  tags = { Name = "Sucursal-USA-SG" }
}

# ---------- INSTANCIAS PRIVADAS POR DEPARTAMENTO ----------

resource "aws_instance" "sucursal_usa_gerencia_ec2_az1" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.sucursal_usa_gerencia_az1.id
  vpc_security_group_ids = [aws_security_group.sucursal_usa_sg.id]
  key_name               = "bastion_key"
  tags = { Name = "Sucursal-USA-Gerencia-EC2-AZ1" }
}
resource "aws_instance" "sucursal_usa_gerencia_ec2_az2" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.sucursal_usa_gerencia_az2.id
  vpc_security_group_ids = [aws_security_group.sucursal_usa_sg.id]
  key_name               = "bastion_key"
  tags = { Name = "Sucursal-USA-Gerencia-EC2-AZ2" }
}

# resource "aws_instance" "sucursal_usa_rh_ec2_az1" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_usa_rh_az1.id
#   vpc_security_group_ids = [aws_security_group.sucursal_usa_sg.id]
#   tags = { Name = "Sucursal-USA-RH-EC2-AZ1" }
# }
# resource "aws_instance" "sucursal_usa_rh_ec2_az2" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_usa_rh_az2.id
#   vpc_security_group_ids = [aws_security_group.sucursal_usa_sg.id]
#   tags = { Name = "Sucursal-USA-RH-EC2-AZ2" }
# }
#
# resource "aws_instance" "sucursal_usa_informatica_ec2_az1" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_usa_informatica_az1.id
#   vpc_security_group_ids = [aws_security_group.sucursal_usa_sg.id]
#   tags = { Name = "Sucursal-USA-Informatica-EC2-AZ1" }
# }
# resource "aws_instance" "sucursal_usa_informatica_ec2_az2" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_usa_informatica_az2.id
#   vpc_security_group_ids = [aws_security_group.sucursal_usa_sg.id]
#   tags = { Name = "Sucursal-USA-Informatica-EC2-AZ2" }
# }
#
# resource "aws_instance" "sucursal_usa_contabilidad_ec2_az1" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_usa_contabilidad_az1.id
#   vpc_security_group_ids = [aws_security_group.sucursal_usa_sg.id]
#   tags = { Name = "Sucursal-USA-Contabilidad-EC2-AZ1" }
# }
# resource "aws_instance" "sucursal_usa_contabilidad_ec2_az2" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_usa_contabilidad_az2.id
#   vpc_security_group_ids = [aws_security_group.sucursal_usa_sg.id]
#   tags = { Name = "Sucursal-USA-Contabilidad-EC2-AZ2" }
# }
#
# resource "aws_instance" "sucursal_usa_ventas_ec2_az1" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_usa_ventas_az1.id
#   vpc_security_group_ids = [aws_security_group.sucursal_usa_sg.id]
#   tags = { Name = "Sucursal-USA-Ventas-EC2-AZ1" }
# }
# resource "aws_instance" "sucursal_usa_ventas_ec2_az2" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_usa_ventas_az2.id
#   vpc_security_group_ids = [aws_security_group.sucursal_usa_sg.id]
#   tags = { Name = "Sucursal-USA-Ventas-EC2-AZ2" }
# }
#
# resource "aws_instance" "sucursal_usa_perifericos_ec2_az1" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_usa_perifericos_az1.id
#   vpc_security_group_ids = [aws_security_group.sucursal_usa_sg.id]
#   tags = { Name = "Sucursal-USA-Perifericos-EC2-AZ1" }
# }
# resource "aws_instance" "sucursal_usa_perifericos_ec2_az2" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_usa_perifericos_az2.id
#   vpc_security_group_ids = [aws_security_group.sucursal_usa_sg.id]
#   tags = { Name = "Sucursal-USA-Perifericos-EC2-AZ2" }
# }
