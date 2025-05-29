variable "ssh_admin_ips" {
  description = "Lista de IPs autorizadas para acceso SSH"
  type        = list(string)
  default     = [
    "190.160.2.44/32",
    "200.85.13.101/32",
    "201.222.120.55/32"
  ]
}

variable "sucursal1_vpc_cidr"      { default = "10.10.0.0/16" }
variable "sucursal1_gerencia_cidr" { default = "10.10.10.0/24" }
variable "sucursal1_rh_cidr"       { default = "10.10.20.0/24" }
variable "sucursal1_informatica_cidr" { default = "10.10.30.0/24" }
variable "sucursal1_contabilidad_cidr" { default = "10.10.40.0/24" }
variable "sucursal1_ventas_cidr"   { default = "10.10.50.0/24" }
variable "sucursal1_perifericos_cidr" { default = "10.10.100.0/24" }



# Variiables de entorno para la sede centra y las subredes por departamento
variable "vpc_cidr_block" {
  description = "CIDR para la VPC principal de la sede central"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR para la subred pública de la sede central"
  type        = string
  default     = "10.0.200.0/24"
}

variable "gerencia_subnet_cidr" {
  description = "CIDR para la subred privada de Gerencia"
  type        = string
  default     = "10.0.10.0/24"
}

variable "rh_subnet_cidr" {
  description = "CIDR para la subred privada de Recursos Humanos"
  type        = string
  default     = "10.0.20.0/24"
}

variable "informatica_subnet_cidr" {
  description = "CIDR para la subred privada de Informática"
  type        = string
  default     = "10.0.30.0/24"
}

variable "contabilidad_subnet_cidr" {
  description = "CIDR para la subred privada de Contabilidad"
  type        = string
  default     = "10.0.40.0/24"
}

variable "ventas_subnet_cidr" {
  description = "CIDR para la subred privada de Ventas"
  type        = string
  default     = "10.0.50.0/24"
}

variable "perifericos_subnet_cidr" {
  description = "CIDR para la subred privada de Periféricos"
  type        = string
  default     = "10.0.100.0/24"
}