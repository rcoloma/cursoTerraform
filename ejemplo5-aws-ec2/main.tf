# AWS: Credenciales

# EC2: Servicio en AWS que proporciona máquinas virtuales
    # Hardware - Tipos: t3.medium
    # AMI: Imagen base
    # Dónde (zona) eu-west-1


/*terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
        }
    }
}*/

module "awsMaquina" {
  source                = "./maquina"
  nombre_ami            = "ami-0176d5cc50152c509"
  tipo_instancia        = "t2.micro"
  nombre_instancia      = "RamonMachine"
}



/*
1.- Montamos un módulo
2.- Valores de vuelta
    IP-Publica
    Tamaño del disco

*/