# AWS: Credenciales

# EC2: Servicio en AWS que proporciona máquinas virtuales
    # Hardware - Tipos: t3.medium
    # AMI: Imagen base
    # Dónde (zona) eu-west-1


terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
        }
    }
}

provider "aws" {
    profile = "default"
    region = "eu-west-1"
    /*
    Terraform_Ramon
AKIAZKASDGV7J4F2B7RK
O/W3jZFwRz94CBv73O7di7Gb32F/LWq8LU0s3/Rl
    */
}

resource "aws_instance" "RamonMachine" {
  ami           = var.nombre_ami
  instance_type = var.tipo_instancia
  tags = {
    Name = var.nombre_instancia
  }
}

/*
1.- Montamos un módulo
2.- Valores de vuelta
    IP-Publica

*/