# ----------------------------------------
# Sucursal Nacional 2 - "sucursal-two.tf"
# ----------------------------------------

resource "aws_vpc" "sucursal_2" {
  cidr_block           = "10.20.0.0/16"
  enable_dns_hostnames = true
  tags = { Name = "VPC-Sucursal-2" }
}

resource "aws_internet_gateway" "sucursal_2_igw" {
  vpc_id = aws_vpc.sucursal_2.id
  tags   = { Name = "Sucursal-2-IGW" }
}

# SUBREDES PUBLICAS
resource "aws_subnet" "sucursal_2_public_az1" {
  vpc_id                  = aws_vpc.sucursal_2.id
  cidr_block              = "10.20.200.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = { Name = "Sucursal-2-Public-AZ1" }
}
resource "aws_subnet" "sucursal_2_public_az2" {
  vpc_id                  = aws_vpc.sucursal_2.id
  cidr_block              = "10.20.201.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = { Name = "Sucursal-2-Public-AZ2" }
}

# SUBREDES PRIVADAS POR DEPARTAMENTO (HA)
resource "aws_subnet" "sucursal_2_gerencia_az1" {
  vpc_id            = aws_vpc.sucursal_2.id
  cidr_block        = "10.20.10.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-2-Gerencia-AZ1" }
}
resource "aws_subnet" "sucursal_2_gerencia_az2" {
  vpc_id            = aws_vpc.sucursal_2.id
  cidr_block        = "10.20.11.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "Sucursal-2-Gerencia-AZ2" }
}
resource "aws_subnet" "sucursal_2_rh_az1" {
  vpc_id            = aws_vpc.sucursal_2.id
  cidr_block        = "10.20.20.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-2-RH-AZ1" }
}
resource "aws_subnet" "sucursal_2_rh_az2" {
  vpc_id            = aws_vpc.sucursal_2.id
  cidr_block        = "10.20.21.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "Sucursal-2-RH-AZ2" }
}
resource "aws_subnet" "sucursal_2_informatica_az1" {
  vpc_id            = aws_vpc.sucursal_2.id
  cidr_block        = "10.20.30.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-2-Informatica-AZ1" }
}
resource "aws_subnet" "sucursal_2_informatica_az2" {
  vpc_id            = aws_vpc.sucursal_2.id
  cidr_block        = "10.20.31.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "Sucursal-2-Informatica-AZ2" }
}
resource "aws_subnet" "sucursal_2_contabilidad_az1" {
  vpc_id            = aws_vpc.sucursal_2.id
  cidr_block        = "10.20.40.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-2-Contabilidad-AZ1" }
}
resource "aws_subnet" "sucursal_2_contabilidad_az2" {
  vpc_id            = aws_vpc.sucursal_2.id
  cidr_block        = "10.20.41.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "Sucursal-2-Contabilidad-AZ2" }
}
resource "aws_subnet" "sucursal_2_ventas_az1" {
  vpc_id            = aws_vpc.sucursal_2.id
  cidr_block        = "10.20.50.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-2-Ventas-AZ1" }
}
resource "aws_subnet" "sucursal_2_ventas_az2" {
  vpc_id            = aws_vpc.sucursal_2.id
  cidr_block        = "10.20.51.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "Sucursal-2-Ventas-AZ2" }
}
resource "aws_subnet" "sucursal_2_perifericos_az1" {
  vpc_id            = aws_vpc.sucursal_2.id
  cidr_block        = "10.20.100.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-2-Perifericos-AZ1" }
}
resource "aws_subnet" "sucursal_2_perifericos_az2" {
  vpc_id            = aws_vpc.sucursal_2.id
  cidr_block        = "10.20.101.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "Sucursal-2-Perifericos-AZ2" }
}

# ROUTE TABLES Y ASOCIACIONES
resource "aws_route_table" "sucursal_2_public_rt" {
  vpc_id = aws_vpc.sucursal_2.id
  tags   = { Name = "Sucursal-2-Public-RT" }
}
resource "aws_route" "sucursal_2_public_internet_access" {
  route_table_id         = aws_route_table.sucursal_2_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.sucursal_2_igw.id
}
resource "aws_route_table_association" "sucursal_2_public_assoc_az1" {
  subnet_id      = aws_subnet.sucursal_2_public_az1.id
  route_table_id = aws_route_table.sucursal_2_public_rt.id
}
resource "aws_route_table_association" "sucursal_2_public_assoc_az2" {
  subnet_id      = aws_subnet.sucursal_2_public_az2.id
  route_table_id = aws_route_table.sucursal_2_public_rt.id
}

resource "aws_route_table" "sucursal_2_private_rt" {
  vpc_id = aws_vpc.sucursal_2.id
  tags   = { Name = "Sucursal-2-Private-RT" }
}
resource "aws_route_table_association" "sucursal_2_informatica_private_assoc_az1" {
  subnet_id      = aws_subnet.sucursal_2_informatica_az1.id
  route_table_id = aws_route_table.sucursal_2_private_rt.id
}
resource "aws_route_table_association" "sucursal_2_informatica_private_assoc_az2" {
  subnet_id      = aws_subnet.sucursal_2_informatica_az2.id
  route_table_id = aws_route_table.sucursal_2_private_rt.id
}

# SECURITY GROUP
resource "aws_security_group" "sucursal_2_private_sg" {
  name        = "Sucursal-2-SG"
  description = "Permite SSH solo desde la sede central"
  vpc_id      = aws_vpc.sucursal_2.id

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
  tags = { Name = "Sucursal-2-SG" }
}

# INSTANCIAS PRIVADAS POR DEPARTAMENTO (HA)
resource "aws_instance" "sucursal_2_gerencia_ec2_az1" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.sucursal_2_gerencia_az1.id
  vpc_security_group_ids = [aws_security_group.sucursal_2_private_sg.id]
  key_name               = "bastion_key"
  tags = { Name = "Sucursal-2-Gerencia-EC2-AZ1" }
}
resource "aws_instance" "sucursal_2_gerencia_ec2_az2" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.sucursal_2_gerencia_az2.id
  vpc_security_group_ids = [aws_security_group.sucursal_2_private_sg.id]
  key_name               = "bastion_key"
  tags = { Name = "Sucursal-2-Gerencia-EC2-AZ2" }
}
# resource "aws_instance" "sucursal_2_rh_ec2_az1" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_2_rh_az1.id
#   vpc_security_group_ids = [aws_security_group.sucursal_2_private_sg.id]
#   tags = { Name = "Sucursal-2-RH-EC2-AZ1" }
# }
# resource "aws_instance" "sucursal_2_rh_ec2_az2" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_2_rh_az2.id
#   vpc_security_group_ids = [aws_security_group.sucursal_2_private_sg.id]
#   tags = { Name = "Sucursal-2-RH-EC2-AZ2" }
# }
# resource "aws_instance" "sucursal_2_informatica_ec2_az1" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_2_informatica_az1.id
#   vpc_security_group_ids = [aws_security_group.sucursal_2_private_sg.id]
#   tags = { Name = "Sucursal-2-Informatica-EC2-AZ1" }
# }
# resource "aws_instance" "sucursal_2_informatica_ec2_az2" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_2_informatica_az2.id
#   vpc_security_group_ids = [aws_security_group.sucursal_2_private_sg.id]
#   tags = { Name = "Sucursal-2-Informatica-EC2-AZ2" }
# }
# resource "aws_instance" "sucursal_2_contabilidad_ec2_az1" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_2_contabilidad_az1.id
#   vpc_security_group_ids = [aws_security_group.sucursal_2_private_sg.id]
#   tags = { Name = "Sucursal-2-Contabilidad-EC2-AZ1" }
# }
# resource "aws_instance" "sucursal_2_contabilidad_ec2_az2" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_2_contabilidad_az2.id
#   vpc_security_group_ids = [aws_security_group.sucursal_2_private_sg.id]
#   tags = { Name = "Sucursal-2-Contabilidad-EC2-AZ2" }
# }
# resource "aws_instance" "sucursal_2_ventas_ec2_az1" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_2_ventas_az1.id
#   vpc_security_group_ids = [aws_security_group.sucursal_2_private_sg.id]
#   tags = { Name = "Sucursal-2-Ventas-EC2-AZ1" }
# }
# resource "aws_instance" "sucursal_2_ventas_ec2_az2" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_2_ventas_az2.id
#   vpc_security_group_ids = [aws_security_group.sucursal_2_private_sg.id]
#   tags = { Name = "Sucursal-2-Ventas-EC2-AZ2" }
# }
# resource "aws_instance" "sucursal_2_perifericos_ec2_az1" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_2_perifericos_az1.id
#   vpc_security_group_ids = [aws_security_group.sucursal_2_private_sg.id]
#   tags = { Name = "Sucursal-2-Perifericos-EC2-AZ1" }
# }
# resource "aws_instance" "sucursal_2_perifericos_ec2_az2" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_2_perifericos_az2.id
#   vpc_security_group_ids = [aws_security_group.sucursal_2_private_sg.id]
#   tags = { Name = "Sucursal-2-Perifericos-EC2-AZ2" }
# }
