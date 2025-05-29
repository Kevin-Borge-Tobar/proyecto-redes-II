terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Provider para sede central (probablemente Colombia)
provider "aws" {
  region = "us-east-1"
}

# Providers para diferentes regiones
provider "aws" {
  alias  = "usa"
  region = "us-west-2"
}

provider "aws" {
  alias  = "espana"
  region = "eu-west-1"
}

# Incluir todos los módulos de sedes
module "sede_central" {
  source = "./sedes"
  # Variables necesarias
}