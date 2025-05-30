# ----------------------------------------
# Sucursal España - "sucursal-espana.tf"
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

# Subredes privadas por departamento (alta disponibilidad, una por AZ)
resource "aws_subnet" "sucursal_espana_gerencia_az1" {
  vpc_id            = aws_vpc.sucursal_espana.id
  cidr_block        = "10.40.10.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-Espana-Gerencia-AZ1" }
}
resource "aws_subnet" "sucursal_espana_gerencia_az2" {
  vpc_id            = aws_vpc.sucursal_espana.id
  cidr_block        = "10.40.11.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "Sucursal-Espana-Gerencia-AZ2" }
}

resource "aws_subnet" "sucursal_espana_rh_az1" {
  vpc_id            = aws_vpc.sucursal_espana.id
  cidr_block        = "10.40.20.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-Espana-RH-AZ1" }
}
resource "aws_subnet" "sucursal_espana_rh_az2" {
  vpc_id            = aws_vpc.sucursal_espana.id
  cidr_block        = "10.40.21.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "Sucursal-Espana-RH-AZ2" }
}

resource "aws_subnet" "sucursal_espana_informatica_az1" {
  vpc_id            = aws_vpc.sucursal_espana.id
  cidr_block        = "10.40.30.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-Espana-Informatica-AZ1" }
}
resource "aws_subnet" "sucursal_espana_informatica_az2" {
  vpc_id            = aws_vpc.sucursal_espana.id
  cidr_block        = "10.40.31.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "Sucursal-Espana-Informatica-AZ2" }
}

resource "aws_subnet" "sucursal_espana_contabilidad_az1" {
  vpc_id            = aws_vpc.sucursal_espana.id
  cidr_block        = "10.40.40.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-Espana-Contabilidad-AZ1" }
}
resource "aws_subnet" "sucursal_espana_contabilidad_az2" {
  vpc_id            = aws_vpc.sucursal_espana.id
  cidr_block        = "10.40.41.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "Sucursal-Espana-Contabilidad-AZ2" }
}

resource "aws_subnet" "sucursal_espana_ventas_az1" {
  vpc_id            = aws_vpc.sucursal_espana.id
  cidr_block        = "10.40.50.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-Espana-Ventas-AZ1" }
}
resource "aws_subnet" "sucursal_espana_ventas_az2" {
  vpc_id            = aws_vpc.sucursal_espana.id
  cidr_block        = "10.40.51.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "Sucursal-Espana-Ventas-AZ2" }
}

resource "aws_subnet" "sucursal_espana_perifericos_az1" {
  vpc_id            = aws_vpc.sucursal_espana.id
  cidr_block        = "10.40.100.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "Sucursal-Espana-Perifericos-AZ1" }
}
resource "aws_subnet" "sucursal_espana_perifericos_az2" {
  vpc_id            = aws_vpc.sucursal_espana.id
  cidr_block        = "10.40.101.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "Sucursal-Espana-Perifericos-AZ2" }
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

resource "aws_route_table_association" "informatica_assoc_az1" {
  subnet_id      = aws_subnet.sucursal_espana_informatica_az1.id
  route_table_id = aws_route_table.sucursal_espana_rt.id
}
resource "aws_route_table_association" "informatica_assoc_az2" {
  subnet_id      = aws_subnet.sucursal_espana_informatica_az2.id
  route_table_id = aws_route_table.sucursal_espana_rt.id
}
# Puedes asociar más privadas según necesites

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

# ---------- INSTANCIAS PRIVADAS POR DEPARTAMENTO ----------

resource "aws_instance" "sucursal_espana_gerencia_ec2_az1" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.sucursal_espana_gerencia_az1.id
  vpc_security_group_ids = [aws_security_group.sucursal_espana_sg.id]
  key_name               = "bastion_key"
  tags = { Name = "Sucursal-Espana-Gerencia-EC2-AZ1" }
}
resource "aws_instance" "sucursal_espana_gerencia_ec2_az2" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.sucursal_espana_gerencia_az2.id
  key_name               = "bastion_key"
  vpc_security_group_ids = [aws_security_group.sucursal_espana_sg.id]
  tags = { Name = "Sucursal-Espana-Gerencia-EC2-AZ2" }
}

# resource "aws_instance" "sucursal_espana_rh_ec2_az1" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_espana_rh_az1.id
#   vpc_security_group_ids = [aws_security_group.sucursal_espana_sg.id]
#   tags = { Name = "Sucursal-Espana-RH-EC2-AZ1" }
# }
# resource "aws_instance" "sucursal_espana_rh_ec2_az2" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_espana_rh_az2.id
#   vpc_security_group_ids = [aws_security_group.sucursal_espana_sg.id]
#   tags = { Name = "Sucursal-Espana-RH-EC2-AZ2" }
# }
#
# resource "aws_instance" "sucursal_espana_informatica_ec2_az1" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_espana_informatica_az1.id
#   vpc_security_group_ids = [aws_security_group.sucursal_espana_sg.id]
#   tags = { Name = "Sucursal-Espana-Informatica-EC2-AZ1" }
# }
# resource "aws_instance" "sucursal_espana_informatica_ec2_az2" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_espana_informatica_az2.id
#   vpc_security_group_ids = [aws_security_group.sucursal_espana_sg.id]
#   tags = { Name = "Sucursal-Espana-Informatica-EC2-AZ2" }
# }
#
# resource "aws_instance" "sucursal_espana_contabilidad_ec2_az1" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_espana_contabilidad_az1.id
#   vpc_security_group_ids = [aws_security_group.sucursal_espana_sg.id]
#   tags = { Name = "Sucursal-Espana-Contabilidad-EC2-AZ1" }
# }
# resource "aws_instance" "sucursal_espana_contabilidad_ec2_az2" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_espana_contabilidad_az2.id
#   vpc_security_group_ids = [aws_security_group.sucursal_espana_sg.id]
#   tags = { Name = "Sucursal-Espana-Contabilidad-EC2-AZ2" }
# }
#
# resource "aws_instance" "sucursal_espana_ventas_ec2_az1" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_espana_ventas_az1.id
#   vpc_security_group_ids = [aws_security_group.sucursal_espana_sg.id]
#   tags = { Name = "Sucursal-Espana-Ventas-EC2-AZ1" }
# }
# resource "aws_instance" "sucursal_espana_ventas_ec2_az2" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_espana_ventas_az2.id
#   vpc_security_group_ids = [aws_security_group.sucursal_espana_sg.id]
#   tags = { Name = "Sucursal-Espana-Ventas-EC2-AZ2" }
# }
#
# resource "aws_instance" "sucursal_espana_perifericos_ec2_az1" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_espana_perifericos_az1.id
#   vpc_security_group_ids = [aws_security_group.sucursal_espana_sg.id]
#   tags = { Name = "Sucursal-Espana-Perifericos-EC2-AZ1" }
# }
# resource "aws_instance" "sucursal_espana_perifericos_ec2_az2" {
#   ami                    = "ami-0c94855ba95c71c99"
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.sucursal_espana_perifericos_az2.id
#   vpc_security_group_ids = [aws_security_group.sucursal_espana_sg.id]
#   tags = { Name = "Sucursal-Espana-Perifericos-EC2-AZ2" }
# }

